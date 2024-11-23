import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/models.dart';

final currentUserProvider = StateProvider<User?>((ref) => null);

final currentUserCoursesProvider = StateProvider<List<Course>?>((ref) => null);

final currentUserMaterialsProvider =
    StateProvider<List<Material>?>((ref) => null);
