import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/consts.dart';
import 'package:uniarchive/firebase_options.dart';
import 'package:uniarchive/helpers.dart';
import 'package:uniarchive/screens/homescreen.dart';
import 'package:uniarchive/screens/signinscreen.dart';
import 'package:uniarchive/screens/signup.dart';
import 'package:uniarchive/screens/uploadscreen.dart';

void main() async {
  // set up dio
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }

  setupDio();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomeScreen.routeId: (context) => const HomeScreen(),
        SignInScreen.routeId: (context) => const SignInScreen(),
        SignUpScreen.routeId: (context) => const SignUpScreen(),
        UploadScreen.routeId: (context) => const UploadScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Uni Archive',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
