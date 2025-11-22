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
  PropertyBuilder(this.getter, this.id);
  final PropertyGetter<T, P> getter;
  final int id;
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

  String? validateSingle(final P value) {
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
  int _counter = 0;

  PropertyBuilder<T, P> property<P>(PropertyGetter<T, P> getter) {
    final id = _counter++;
    final PropertyBuilder<T, P> p = PropertyBuilder<T, P>(getter, id);
    _props.add(p);
    return p;
  }

  List<String> validate(T model) {
    return _props.expand((p) => p.validate(model)).toList();
  }

  String? validateSingle(int id, dynamic value) {
    final prop = _props.where((x) => x.id == id).first;
    return prop.validateSingle(value);
  }
}
