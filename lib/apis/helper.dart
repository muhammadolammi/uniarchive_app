import 'dart:developer';

import 'package:firebase_app_check/firebase_app_check.dart';

void debugAppCheck() async {
  final token = await FirebaseAppCheck.instance.getToken(true);
  log("App Check token: $token");
}
