import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path/path.dart' as path;
import 'package:uniarchive/apis/firebase/firebase.dart';
import 'package:uniarchive/apis/materials.dart';
import 'package:uniarchive/main.dart';
// import 'package:uniarchive/consts.dart';
import 'package:uniarchive/providers/provider.dart';
import 'package:uniarchive/providers/uploadscreenstate.dart';
import 'package:uniarchive/screens/homescreen.dart';
// import 'package:uniarchive/widgets/coursesdropdown.dart';
import 'package:uniarchive/widgets/showsnackbar.dart';

class UploadScreen extends ConsumerStatefulWidget {
  static const String routeId = "/uploadRoute";
  const UploadScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadscreenState();
}

class _UploadscreenState extends ConsumerState<UploadScreen> {
  PlatformFile? file;
  final materialNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final currentUser = ref.watch(currentUserProvider);
    final courseID = ref.watch(courseIDProvider);
    final courses = ref.watch(currentUserCoursesProvider)!;

    return Scaffold(
      body: SafeArea(
          child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // upload and file preview here

          Container(
            margin: const EdgeInsets.all(20),
            child: DropdownButton(
                value: courseID, // Current selected value
                hint: const Text('Choose a Course'),
                isExpanded: true,
                items: courses.map((course) {
                  return DropdownMenuItem<String>(
                    value: course.id, // Value to be selected
                    child: Text(
                        "${course.name}(${course.courseCode})"), // Displayed text
                  );
                }).toList(),
                onChanged: (newID) {
                  ref.read(courseIDProvider.notifier).state = newID;
                  log(newID ?? "no id ");
                }),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            margin: const EdgeInsets.all(20),
            // color: Colors.grey[100],
            child: Center(
              child: file == null
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles();
                        if (result == null) return;
                        // final file = result.files.first;
                        // openFile(file);
                        setState(() {
                          file = result.files.first;
                        });
                      },
                      child: const Text(
                        "Choose File",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(file!.name),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              file = null;
                            });
                          },
                          child: const Icon(
                            Icons.cancel_outlined,
                            size: 15,
                            // color: Colors.white,
                          ),
                        ),
                      ],
                    ),
            ),
          ),

          Center(
            child: ElevatedButton(
              onPressed: () async {
                ref
                    .read(firebaseApiProvider)
                    .uploadFile(
                      file!,
                    )
                    .then((downloadurl) {
                  if (courseID == null) {
                    showSnackBar(context: context, content: "choose a course");
                    return;
                  }
                  ref
                      .read(materialApiProvider)
                      .uploadCourseMaterial(MaterialUploadParams(
                        name: file!.name,
                        cloudUrl: downloadurl,
                        // TODO add course id here
                        courseID: courseID,
                      ))
                      .then((message) {
                    showSnackBar(context: context, content: message);
                    context.go(HomeScreen.routeId);
                  }).catchError((e) {
                    showSnackBar(context: context, content: e);
                  });
                  log(downloadurl);
                }).catchError((e) {
                  showSnackBar(context: context, content: e);
                  // log("error $e");
                });
              },
              child: Text("Upload"),
            ),
          ),
          SizedBox(
            height: 250,
          )
        ],
      )),
    );
  }
}
