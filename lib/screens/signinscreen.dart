import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/apis/auth.dart';
import 'package:uniarchive/providers/auth.dart';
import 'package:uniarchive/screens/homescreen.dart';
import 'package:uniarchive/screens/signup.dart';
import 'package:uniarchive/widgets/showsnackbar.dart';

class SignInScreen extends ConsumerStatefulWidget {
  static String routeId = 'signInRoute';

  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SigninscreenState();
}

class _SigninscreenState extends ConsumerState<SignInScreen> {
  // Controllers for form fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "Sign In",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.black,
      // ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      ref
                          .refresh(signINProvider(SigninParams(
                        email: emailController.text,
                        password: passwordController.text,
                      )).future)
                          .then((value) {
                        // Handle success
                        log("Sign-in successful: $value");
                        showSnackBar(
                            content: 'User logged in successfully',
                            context: context);
                        Navigator.pushNamed(context, HomeScreen.routeId);
                        // Navigate or display a success message if needed
                      }).catchError((error) {
                        // Check error type and show a user-friendly message
                        if (error is DioException) {
                          showSnackBar(
                              content: 'Dio Error: ${error.message}',
                              context: context);
                        } else {
                          showSnackBar(
                              content: 'Error $error', context: context);
                        }
                      });
                    },
                    child: const Text("Sign In")),

                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Text("Don't have an account?"),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          // Handle navigation or action here
                          Navigator.pushNamed(context, SignUpScreen.routeId);
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.blue),
                        )),
                  ],
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       Navigator.pushNamed(context, HomeScreen.routeId);
                //     },
                //     child: const Text("Go to Home")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
