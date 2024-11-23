import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/consts.dart';

final facultiesApiProvider = Provider((ref) {
  return FacultiesApi();
});

class FacultiesApi {
  Future<List<Map<String, dynamic>>> getFaculties(String universityID) async {
    try {
      final response = await dio.get("/faculties/$universityID");
      if (response.statusCode == 200) {
        final data = List<Map<String, dynamic>>.from(response.data);
        // log("Parsed data: $data");
        if (data.isEmpty) {
          return [
            {"name": "No faculty yet, add if you are the admin"}
          ];
        }
        return data;
      } else {
        log("Failed with status code: ${response.statusCode}");
        throw Exception('Failed to get faculties: ${response.statusCode}');
      }
    } catch (e) {
      log("Error fetching faculties: $e");
      throw Exception('Error: $e');
    }
  }
}
