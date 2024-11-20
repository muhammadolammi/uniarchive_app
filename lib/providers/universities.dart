import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/apis/universities_api.dart';

final universityListProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final universityApi = ref.read(universitiesApiProvider);
  return await universityApi.getUniversities();
});
