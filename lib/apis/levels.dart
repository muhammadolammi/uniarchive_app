import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/consts.dart';

final levelsApiProvider = Provider((ref) {
  return LevelsApi();
});

class LevelsApi {
  Future<List<Map<String, dynamic>>> getLevels() async {
    try {
      final response = await dio.get("/levels");
      if (response.statusCode == 200) {
        final data = List<Map<String, dynamic>>.from(response.data);
        // log("Parsed data: $data");
        return data;
      } else {
        log("Failed with status code: ${response.statusCode}");
        throw Exception('Failed to get levels: ${response.statusCode}');
      }
    } catch (e) {
      log("Error fetching levels: $e");
      throw Exception('Error: $e');
    }
  }
}
