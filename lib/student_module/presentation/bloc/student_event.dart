part of 'student_bloc.dart';

@immutable
sealed class StudentFormEvent {}

class FirstnameChanged extends StudentFormEvent {
  final String value;
  FirstnameChanged(this.value);
}

class LastnameChanged extends StudentFormEvent {
  final String value;
  LastnameChanged(this.value);
}

class EmailChanged extends StudentFormEvent {
  final String value;
  EmailChanged(this.value);
}

class SubmitForm extends StudentFormEvent {}
