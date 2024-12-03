import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uniarchive/apis/auth.dart';
import 'package:uniarchive/apis/courses.dart';
import 'package:uniarchive/apis/materials.dart';
import 'package:uniarchive/main.dart';
import 'package:uniarchive/models.dart';
import 'package:uniarchive/providers/courses.dart';
import 'package:uniarchive/providers/provider.dart';
import 'package:uniarchive/screens/signinscreen.dart';
import 'package:uniarchive/screens/signup.dart';
import 'package:uniarchive/screens/uploadscreen.dart';
import 'package:uniarchive/widgets/coursesdropdown.dart';
import 'package:uniarchive/widgets/fileCard.dart';
import 'package:uniarchive/widgets/profilecard.dart';
import 'package:uniarchive/widgets/roundformfield.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeId = '/';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // TODO UNCOMMENT

  bool _isCheckingAuth = true;

  @override
  void initState() {
    super.initState();
    // Validate user on init.
    final authApi = ref.read(authApiProvider);
    final coursesApi = ref.read(courseApiProvider);
    final materialApi = ref.read(materialApiProvider);

    // update the current user
    authApi.validate().then((currentUser) {
      ref.read(currentUserProvider.notifier).state = currentUser;

      // after getting the user lets get the courses for that user
      coursesApi.getUserCourses(currentUser.id).then(
        (courses) {
          ref.read(currentUserCoursesProvider.notifier).state = courses;
        },
      );

      // set the current materials to default
      materialApi
          .getCourseMaterials("default", currentUser.departmentID)
          .then((materials) {
        ref.read(currentUserMaterialsProvider.notifier).state = materials;
      });
      // update loading to done

      setState(() {
        _isCheckingAuth = false;
      });
    }).catchError((e) {
      // Redirect to the SignInScreen if validation fails
      context.go(SignInScreen.routeId);

      // Navigator.pushReplacementNamed(context, SignInScreen.routeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isCheckingAuth) {
      // Show a loading screen or spinner while checking authentication
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final currentUser = ref.watch(currentUserProvider);
    // final courses = ref.watch(currentUserCoursesProvider);
    final materials = ref.watch(currentUserMaterialsProvider);

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "Uni Archive",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.black,
      //   leading: Center(
      //     child: currentUser?.profileUrl != null &&
      //             currentUser!.profileUrl.isNotEmpty
      //         ? CircleAvatar(
      //             radius: 20,
      //             backgroundImage: NetworkImage(currentUser.profileUrl),
      //           )
      //         : const CircleAvatar(
      //             radius: 20,
      //             backgroundColor: Colors.grey,
      //             child: Icon(Icons.person, color: Colors.white),
      //           ),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(UploadScreen.routeId);
        },
        child: const Icon(Icons.upload),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, ${currentUser?.firstName ?? "Guest"}",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              const Text(
                "Manage and get Materials",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Roundformfield(
              //   hintText: "Search here...",
              // ),

              // Center(
              //     child: Profilecard(
              //   user: currentUser ?? User.emptyUser(),
              // )),
              const CoursesDropdown(),
              Column(
                children: materials == null
                    ? [
                        const CircularProgressIndicator()
                      ] // Show loading indicator while fetching materials
                    : materials.isEmpty
                        ? [
                            const Text("No materials available")
                          ] // If materials is empty
                        : materials.map((material) {
                            return Filecard(
                                material:
                                    material); // Assuming you want to show a file card for each material
                          }).toList(),
              ),

              //  TESTING BUTTONS
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.pushNamed(context, SignUpScreen.routeId);
              //     },
              //     child: Text("Go to Sign Up")),
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.pushNamed(context, SignInScreen.routeId);
              //     },
              //     child: Text("Go to Sign In")),
            ],
          ),
        ),
      ),
    );
  }
}
