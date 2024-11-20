import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/consts.dart';

final departmentsApiProvider = Provider((ref) {
  return DepartmentsApi();
});

class DepartmentsApi {
  Future<List<Map<String, dynamic>>> getDepartments(String facultyID) async {
    final Uri url = Uri.parse('$baseUrl/departments/$facultyID');
    // log("api url $url");
    try {
      final response = await Dio().get(
        url.toString(),
      );
      if (response.statusCode == 200) {
        final data = List<Map<String, dynamic>>.from(response.data);
        // log("Parsed data: $data");
        if (data.length == 0) {
          return [
            {"name": "No department yet, add if you are the admin"}
          ];
        }
        return data;
      } else {
        log("Failed with status code: ${response.statusCode}");
        throw Exception('Failed to get departments: ${response.statusCode}');
      }
    } catch (e) {
      log("Error fetching departments: $e");
      throw Exception('Error: $e');
    }
  }
}
