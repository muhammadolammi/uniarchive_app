import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/apis/auth.dart';
import 'package:uniarchive/providers/auth.dart';
import 'package:uniarchive/providers/departments.dart';
import 'package:uniarchive/providers/faculties.dart';
import 'package:uniarchive/providers/levels.dart';
import 'package:uniarchive/providers/signupstates.dart';
import 'package:uniarchive/providers/universities.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  // Controllers for form fields
  final emailController = TextEditingController();
  final matricController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final otherNameController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    matricController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    otherNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // university data
    final universities = ref.watch(universityListProvider).asData?.value ?? [];
    final universityID = ref.watch(universityIDProvider);
    // faculty data
    final facultiesAsyncValue = ref.watch(
      facultyListProvider(universityID ?? ''),
    );
    final faculties = facultiesAsyncValue.asData?.value ??
        [
          {"name": "Choose a Faculty"}
        ];
    final facultyID = ref.watch(facultyIDProvider);

    // department data

    final departmentssAsyncValue = ref.watch(
      departmentListProvider(facultyID ?? ''),
    );
    final departments = departmentssAsyncValue.asData?.value ??
        [
          {"name": "Choose a Department"}
        ];
    final departmentID = ref.watch(departmentIDProvider);
    // level data
    final levels = ref.watch(levelListProvider).asData?.value ??
        [
          {"name": "choose a level"}
        ];
    final levelID = ref.watch(levelIDProvider);

    //signup function
    final SignupParams signupParams = SignupParams(
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        password: passwordController.text,
        matricNumber: matricController.text,
        universityID: universityID ?? "",
        departmentID: departmentID ?? "",
        facultyID: facultyID ?? "",
        levelID: levelID ?? "");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Fill in Information",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                ),
              ),
              TextFormField(
                controller: matricController,
                decoration: const InputDecoration(
                  labelText: 'Matric Number',
                  hintText: 'Enter your matric number',
                ),
              ),
              TextFormField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  hintText: 'Enter your first name',
                ),
              ),
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  hintText: 'Enter your last name',
                ),
              ),
              TextFormField(
                controller: otherNameController,
                decoration: const InputDecoration(
                  labelText: 'Other Name',
                  hintText: 'Enter your other name (optional)',
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
              // CHOOSING A UNIVERSITY
              DropdownButton(
                  value: universityID, // Current selected value
                  hint: const Text('Choose a University'),
                  isExpanded: true,
                  items: universities.map((uni) {
                    return DropdownMenuItem<String>(
                      value: uni['id'], // Value to be selected
                      child: Text(uni['name']), // Displayed text
                    );
                  }).toList(),
                  onChanged: (newID) {
                    ref.read(universityIDProvider.notifier).state = newID;
                    log(newID ?? "no id ");
                  }),
              // CHOOSING A FACULTY
              DropdownButton(
                  value: facultyID, // Current selected value
                  hint: const Text('Choose a Faculty'),
                  isExpanded: true,
                  items: faculties.map((faculty) {
                    return DropdownMenuItem<String>(
                      value: faculty['id'], // Value to be selected
                      child: Text(faculty['name']), // Displayed text
                    );
                  }).toList(),
                  onChanged: (newID) {
                    ref.read(facultyIDProvider.notifier).state = newID;
                    log(newID ?? "no id ");
                  }),
              // CHOOSING A DEPARTMENT
              DropdownButton(
                  value: departmentID, // Current selected value
                  hint: const Text('Choose a Department'),
                  isExpanded: true,
                  items: departments.map((department) {
                    return DropdownMenuItem<String>(
                      value: department['id'], // Value to be selected
                      child: Text(department['name']), // Displayed text
                    );
                  }).toList(),
                  onChanged: (newID) {
                    ref.read(departmentIDProvider.notifier).state = newID;
                    log(newID ?? "no id ");
                  }),
              // CHOOSING A LEVEL
              DropdownButton(
                  value: levelID, // Current selected value
                  hint: const Text('Choose a Level'),
                  isExpanded: true,
                  items: levels.map((level) {
                    return DropdownMenuItem<String>(
                      value: level['id'], // Value to be selected
                      child: Text(level['code'].toString()), // Displayed text
                    );
                  }).toList(),
                  onChanged: (newID) {
                    ref.read(levelIDProvider.notifier).state = newID;
                    log(newID ?? "no id ");
                  }),
              ElevatedButton(
                  onPressed: () {
                    ref
                        .refresh(signUPProvider(signupParams).future)
                        .then((value) {
                      // Handle success
                      log("Sign-up successful: $value");
                      // Navigate or display a success message if needed
                    }).catchError((error) {
                      // Handle error
                      throw ("$error");
                      // Display an error message to the user
                    });
                  },
                  child: Text("Sign Up")),
              const Row(
                children: [
                  const Text("Already have an account?"),
                  SizedBox(
                    width: 10,
                  ),
                  const Text("Sign In"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
