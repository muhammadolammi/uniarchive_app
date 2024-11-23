import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/consts.dart';
import 'package:uniarchive/models.dart';

final materialApiProvider = Provider((ref) {
  return MaterialsApi();
});

class MaterialsApi {
  Future<List<Material>> getCourseMaterials(
      String courseID, String? departmentID) async {
    try {
      Response response;

      if (courseID == "default") {
        response = await dio.get(
          "/materials/default",
          queryParameters:
              departmentID != null ? {"department_id": departmentID} : null,
        );
      } else {
        response = await dio.get("/materials/$courseID");
      }
      if (response.statusCode == 200) {
        final data = List<dynamic>.from(response.data);
        // log("Parsed data: $data");
        if (data.isEmpty) {}
        return Material.jsonToList(response.data);
      } else {
        log("Failed with status code: ${response.statusCode}");
        throw Exception('Failed to get Materials: ${response.statusCode}');
      }
    } on DioException catch (e) {
      log("Error fetching Materials: ${e.response?.data.toString()}");
      throw Exception('Error: $e');
    } catch (e) {
      log("Error fetching Materials: ${e}");
      throw Exception('Error: $e');
    }
  }
}
