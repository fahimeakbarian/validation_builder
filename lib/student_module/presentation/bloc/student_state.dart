part of 'student_bloc.dart';

@immutable
class StudentFormState {
  final String firstname;
  final String? firstnameError;

  final String lastname;
  final String? lastnameError;

  final String email;
  final String? emailError;

  const StudentFormState({
    this.firstname = '',
    this.firstnameError,
    this.lastname = '',
    this.lastnameError,
    this.email = '',
    this.emailError,
  });

  StudentFormState copyWith({
    String? firstname,
    String? firstnameError,
    String? lastname,
    String? lastnameError,
    String? email,
    String? emailError,
  }) {
    return StudentFormState(
      firstname: firstname ?? this.firstname,
      firstnameError: firstnameError ?? this.firstnameError,
      lastname: lastname ?? this.lastname,
      lastnameError: lastnameError ?? this.lastnameError,
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
    );
  }
}
