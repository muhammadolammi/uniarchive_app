import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uniarchive/consts.dart';
import 'package:uniarchive/screens/homescreen.dart';
import 'package:uniarchive/screens/signinscreen.dart';
import 'package:uniarchive/screens/signup.dart';
import 'package:uniarchive/screens/uploadscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await FirebaseAppCheck.instance.activate(
      androidProvider:
          kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity);

  // set up dio

  setupDio();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Uni Archive',
      routerConfig: _router,
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

final GoRouter _router = GoRouter(
  initialLocation: HomeScreen.routeId,
  routes: [
    GoRoute(
      path: SignInScreen.routeId,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: SignUpScreen.routeId,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: HomeScreen.routeId,
      builder: (context, state) => const HomeScreen(),
      routes: [
        // Sub-route for upload
        GoRoute(
          path: UploadScreen.routeId, // This becomes '/home/upload'
          builder: (context, state) => const UploadScreen(),
        ),
        // Add more sub-routes here if needed
      ],
    ),
  ],
);
