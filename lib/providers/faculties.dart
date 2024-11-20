import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/apis/faculties.dart';

final facultyListProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>(
        (ref, universityID) async {
  final facultyApi = ref.read(facultiesApiProvider);
  return await facultyApi.getFaculties(universityID);
});
