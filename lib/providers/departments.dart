import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/apis/departments.dart';

final departmentListProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>(
        (ref, facultyID) async {
  final departmentApi = ref.read(departmentsApiProvider);
  return await departmentApi.getDepartments(facultyID);
});
