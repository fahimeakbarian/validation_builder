import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/student_module/domain/student_entity.dart';
import 'package:flutter_project/student_module/domain/student_validation.dart';
import 'package:meta/meta.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentFormBloc extends Bloc<StudentFormEvent, StudentFormState> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final StudentValidator studentValidator = StudentValidator();

  StudentFormBloc() : super(StudentFormState()) {
    on<FirstnameChanged>((event, emit) {
      final entity = StudentEntity(
        firstname: event.value,
        lastname: state.lastname,
        email: state.email,
      );

      final error = studentValidator.validateFirstName(entity);

      final newState = state.copyWith(
        firstname: event.value,
        firstnameError: error,
      );

      emit(newState);
    });

    on<LastnameChanged>((event, emit) {
      final entity = StudentEntity(
        firstname: state.firstname,
        lastname: event.value,
        email: state.email,
      );

      final error = studentValidator.validateLastName(entity);

      final newState = state.copyWith(
        lastname: event.value,
        lastnameError: error,
      );

      emit(newState);
    });

    on<EmailChanged>((event, emit) {
      final entity = StudentEntity(
        firstname: state.firstname,
        lastname: state.lastname,
        email: event.value,
      );

      final error = studentValidator.validateEmail(entity);
      final newState = state.copyWith(email: event.value, emailError: error);

      emit(newState);
    });

    on<SubmitForm>((event, emit) {
      final entity = StudentEntity(
        firstname: state.firstname,
        lastname: state.lastname,
        email: state.email,
      );

      final errors = studentValidator.validator.validate(entity);
      if (errors.isEmpty) {
        // success
      }
    });
  }

  @override
  Future<void> close() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    return super.close();
  }
}
