abstract class Rule<T> {
  String? validate(final T value);
}

class RequiredRule<T> extends Rule<T> {
  RequiredRule(this.message);

  final String message;

  @override
  String? validate(final T value) {
    if (value == null || (value is String && value.trim().isEmpty)) {
      return message;
    }
    return null;
  }
}

class MaxLengthRule<T> extends Rule<T> {
  MaxLengthRule(this.max, this.message);

  final int max;
  final String message;

  @override
  String? validate(final T value) {
    if (value is String && value.length > max) {
      return message;
    }
    return null;
  }
}

class RegexRule<T> extends Rule<T> {
  RegexRule(this.pattern, this.message);

  final RegExp pattern;
  final String message;

  @override
  String? validate(final T value) {
    if (value is String && !pattern.hasMatch(value)) {
      return message;
    }
    return null;
  }
}

typedef PropertyGetter<T, P> = P Function(T);

class PropertyBuilder<T, P> {
  PropertyBuilder(this.getter);
  final PropertyGetter<T, P> getter;
  final List<Rule<P>> _rules = <Rule<P>>[];

  PropertyBuilder<T, P> isNotEmpty({final String message = "is empty"}) {
    _rules.add(RequiredRule<P>(message));
    return this;
  }

  PropertyBuilder<T, P> maxLength(
    final int max, {
    final String message = "too long",
  }) {
    _rules.add(MaxLengthRule<P>(max, message));
    return this;
  }

  PropertyBuilder<T, P> matches(
    final RegExp pattern, {
    final String message = "invalid format",
  }) {
    _rules.add(RegexRule<P>(pattern, message));
    return this;
  }

  String? validateSingle(P value) {
    for (final Rule<P> rule in _rules) {
      final String? error = rule.validate(value);
      if (error != null) return error;
    }
    return null;
  }

  List<String> validate(final T model) {
    final value = getter(model);

    return _rules
        .map((final Rule<P> r) => r.validate(value))
        .where((final String? msg) => msg != null)
        .cast<String>()
        .toList();
  }
}

class ValidationBuilder<T> {
  final List<PropertyBuilder<T, dynamic>> _props = [];

  PropertyBuilder<T, P> property<P>(PropertyGetter<T, P> getter) {
    final PropertyBuilder<T, P> pb = PropertyBuilder<T, P>(getter);
    _props.add(pb);
    return pb;
  }

  List<String> validate(T model) {
    return _props.expand((p) => p.validate(model)).toList();
  }

  String? validateSingle<P>(T model, PropertyBuilder<T, P> property) {
    final value = property.getter(model);
    return property.validateSingle(value);
  }
}
