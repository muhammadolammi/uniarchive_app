import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/consts.dart';
import 'package:uniarchive/models.dart';

class MaterialUploadParams {
  final String name;
  final String courseID;
  final String cloudUrl;

  // Constructor to initialize the fields
  MaterialUploadParams({
    required this.name,
    required this.cloudUrl,
    required this.courseID,
  });

  // Optionally, you can add a method to convert the object to JSON (for API requests)
  Map<String, dynamic> toJson() {
    final data = {
      "name": name,
      "course_id": courseID,
      "cloud_url": cloudUrl,
    };
    return data;
  }
}

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

  Future uploadCourseMaterial(MaterialUploadParams params) async {
    try {
      final response = await dio.post("/materials", data: params.toJson());

      log("material saved succussfully");
      return response.toString();
    } on DioException catch (e) {
      throw Exception(e.response.toString());
    } catch (e) {
      throw Exception(e);
    }
  }
}
