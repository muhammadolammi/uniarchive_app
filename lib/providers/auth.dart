import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/apis/auth.dart';

final signUPProvider =
    FutureProvider.family<String, SignupParams>((ref, params) async {
  final authProvider = ref.read(authApiProvider);
  return await authProvider.signUp(params);
});
