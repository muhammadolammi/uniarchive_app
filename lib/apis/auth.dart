import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/consts.dart';
import 'package:uniarchive/models.dart';

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

class SigninParams {
  final String email;

  final String password;

  // Constructor to initialize the fields
  SigninParams({
    required this.email,
    required this.password,
  });
  // Optionally, you can add a method to convert the object to JSON (for API requests)
  Map<String, dynamic> toJson() {
    final data = {
      "email": email,
      "password": password,
    };
    return data;
  }
}

class AuthApi {
  Future<String> signUp(SignupParams params) async {
    try {
      final response = await dio.post("/signup", data: params.toJson());

      log("user created succussfully");
      return response.toString();
    } on DioException catch (e) {
      throw Exception(e.response.toString());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> signIn(SigninParams params) async {
    try {
      final response = await dio.post("/signin", data: params.toJson());

      log("user logged in succussfully");
      return response.toString();
    } on DioException catch (e) {
      throw Exception(e.response?.data['error']);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User> validate() async {
    // final Uri url = Uri.parse('$baseUrl/validate');

    try {
      final response =
          await dio.post("/validate").timeout(const Duration(seconds: 10));
      final data = Map<String, dynamic>.from(response.data);
      // log(data.toString());
      return User.fromJson(data);
    } on DioException catch (e) {
      log("here");
      log(e.response.toString());
      throw Exception(e.response?.data['error']);
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
