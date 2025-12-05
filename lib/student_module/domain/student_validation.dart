import 'package:flutter_project/core/validation_utils.dart';
import 'package:flutter_project/student_module/domain/student_entity.dart';

class StudentValidator {
  final validator = ValidationBuilder<StudentEntity>();

  late final PropertyBuilder<StudentEntity, String?> firstName;
  late final PropertyBuilder<StudentEntity, String?> email;
  late final PropertyBuilder<StudentEntity, String?> lastName;

  StudentValidator() {
    lastName = validator
        .property((s) => s.lastname)
        .isNotEmpty(message: "lastname  required")
        .maxLength(3);

    firstName = validator
        .property((s) => s.firstname)
        .isNotEmpty(message: "First name required")
        .maxLength(3);

    email = validator
        .property((s) => s.email)
        .matches(RegExp(r".+@.+\..+"), message: "Invalid email");
  }

  List<String> validate(StudentEntity model) {
    return validator.validate(model);
  }

  String? validateFirstName(StudentEntity model) {
    return validator.validateSingle(model, firstName);
  }

  String? validateEmail(StudentEntity model) {
    return validator.validateSingle(model, email);
  }

  String? validateLastName(StudentEntity model) {
    return validator.validateSingle(model, lastName);
  }
}
