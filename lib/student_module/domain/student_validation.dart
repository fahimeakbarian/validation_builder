import 'package:flutter_project/core/validation_utils.dart';
import 'package:flutter_project/student_module/domain/student_entity.dart';

//
// class StudentValidator {
//   final ValidationBuilder<StudentEntity> validator =
//       ValidationBuilder<StudentEntity>();
//
//   static final firstnameGetter = (StudentEntity s) => s.firstname;
//   static final lastnameGetter = (StudentEntity s) => s.lastname;
//   static final emailGetter = (StudentEntity s) => s.email;
//
//   StudentValidator() {
//     validator
//         .property(firstnameGetter)
//         .isNotEmpty(message: "First name cannot be empty")
//         .maxLength(3);
//
//     validator
//         .property((s) => s.lastname)
//         .isNotEmpty(message: "Last name cannot be empty")
//         .maxLength(20);
//
//     validator
//         .property((s) => s.email)
//         .isNotEmpty(message: "Email cannot be empty")
//         .matches(
//           RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$"),
//           message: "Email format invalid",
//         );
//   }
// }
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
