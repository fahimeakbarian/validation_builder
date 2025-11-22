import 'package:flutter_project/core/validation_utils.dart';
import 'package:flutter_project/student_module/domain/student_entity.dart';

class StudentValidator {
  late final int firstnameId;
  late final int lastnameId;
  late final int emailId;

  final validator = ValidationBuilder<StudentEntity>();

  StudentValidator() {
    firstnameId = validator
        .property((s) => s.firstname)
        .isNotEmpty(message: "First name required")
        .maxLength(3)
        .id;

    lastnameId = validator
        .property((s) => s.lastname)
        .isNotEmpty(message: "Last name required")
        .maxLength(3)
        .id;

    emailId = validator
        .property((s) => s.email)
        .matches(RegExp(r".+@.+\..+"), message: "Invalid email")
        .id;
  }
}
