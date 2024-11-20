import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/consts.dart';

final authApiProvider = Provider((ref) {
  return AuthApi();
});

class SignupParams {
  final String email;
  final String firstName;
  final String lastName;
  final String? otherName;

  final String password;
  final String matricNumber;
  final String universityID;
  final String facultyID;
  final String departmentID;
  final String levelID;

  final authApiProvider = Provider((ref) {
    return AuthApi();
  });

  // Constructor to initialize the fields
  SignupParams(
      {required this.email,
      required this.firstName,
      required this.lastName,
      this.otherName,
      required this.password,
      required this.matricNumber,
      required this.universityID,
      required this.departmentID,
      required this.facultyID,
      required this.levelID});

  // Optionally, you can add a method to convert the object to JSON (for API requests)
  Map<String, dynamic> toJson() {
    final data = {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "other_name": otherName,
      "password": password,
      "matric_number": matricNumber,
      "university_id": universityID,
      "faculty_id": facultyID,
      "department_id": departmentID,
      "level_id": levelID
    };
    return data;
  }
}

class AuthApi {
  Future<String> signUp(SignupParams params) async {
    final Uri url = Uri.parse('$baseUrl/signup');
    log(params.toString());
    try {
      final response = await Dio().post(url.toString(), data: params.toJson());

      log("user created succussfully");
      return response.toString();
    } on DioException catch (e) {
      throw Exception('Error: ${e.response.toString()}');
    }
  }
}
