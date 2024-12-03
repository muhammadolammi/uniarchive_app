import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

const String baseUrl = "http://172.23.206.70:8080/api";

final Dio dio = Dio();
final CookieJar cookieJar = CookieJar();
final storageRef = FirebaseStorage.instance.ref();

void setupDio() {
  dio.interceptors.add(CookieManager(cookieJar));
  dio.options.baseUrl = baseUrl; // Your API base URL
  dio.options.headers['Content-Type'] = 'application/json';
}
