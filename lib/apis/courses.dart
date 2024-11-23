import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/consts.dart';
import 'package:uniarchive/models.dart';

final courseApiProvider = Provider((ref) {
  return CoursesApi();
});

class CoursesApi {
  Future<List<Course>> getUserCourses(String userID) async {
    try {
      final response = await dio.get("/courses/$userID");
      if (response.statusCode == 200) {
        final data = List<dynamic>.from(response.data);
        // log("Parsed data: $data");
        if (data.isEmpty) {}
        return Course.jsonToList(response.data);
      } else {
        log("Failed with status code: ${response.statusCode}");
        throw Exception('Failed to get Courses: ${response.statusCode}');
      }
    } catch (e) {
      log("Error fetching courses: $e");
      throw Exception('Error: $e');
    }
  }
}
