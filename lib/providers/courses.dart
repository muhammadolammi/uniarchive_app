import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/apis/courses.dart';
import 'package:uniarchive/models.dart';

final userCourseListProvider =
    FutureProvider.family<List<Course>, String>((ref, userID) async {
  final courseApi = ref.read(courseApiProvider);
  return await courseApi.getUserCourses(userID);
});
