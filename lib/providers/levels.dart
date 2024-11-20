import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/apis/levels.dart';

final levelListProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final levelsApi = ref.read(levelsApiProvider);
  return await levelsApi.getLevels();
});
