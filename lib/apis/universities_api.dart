import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/consts.dart';

final universitiesApiProvider = Provider((ref) {
  return UniversitiesApi();
});

class UniversitiesApi {
  Future<List<Map<String, dynamic>>> getUniversities() async {
    final Uri url = Uri.parse('$baseUrl/universities');
    // log("api url $url");
    try {
      final response = await Dio().get(
        url.toString(),
      );
      if (response.statusCode == 200) {
        final data = List<Map<String, dynamic>>.from(response.data);
        // log("Parsed data: $data");
        return data;
      } else {
        log("Failed with status code: ${response.statusCode}");
        throw Exception('Failed to get universities: ${response.statusCode}');
      }
    } catch (e) {
      log("Error fetching universities: $e");
      throw Exception('Error: $e');
    }
  }
}
