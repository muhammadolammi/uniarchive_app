import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/apis/materials.dart';
import 'package:uniarchive/providers/provider.dart';
import 'package:uniarchive/widgets/showsnackbar.dart';

class CoursesDropdown extends ConsumerStatefulWidget {
  const CoursesDropdown({super.key});

  @override
  ConsumerState<CoursesDropdown> createState() => _CoursesDropdownState();
}

class _CoursesDropdownState extends ConsumerState<CoursesDropdown> {
  String? selectedCourseId; // Holds the selected course ID

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);

    final courses = ref.watch(currentUserCoursesProvider);
    final materialApi = ref.read(materialApiProvider);
    if (courses == null || courses.isEmpty) {
      // Handle the null or empty state
      return const Text("No courses available");
    }
    final dropdownItems = [
      DropdownMenuItem<String>(
        value: "default",
        child: const Text('Default'), // Default option displayed text
      ),
      ...courses.map((course) {
        return DropdownMenuItem<String>(
          value: course.id, // Course ID to be sent to backend
          child: Text(course.courseCode), // Course name displayed
        );
      }),
    ];

    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: DropdownButton(
        hint: const Text('Default'),
        value: selectedCourseId,
        isExpanded: true,
        // items: courses.map((course) {
        //   return DropdownMenuItem<String>(
        //     value: course.id, // Value to be selected
        //     child: Text(course.courseCode), // Displayed text
        //   );
        // }).toList(),
        items: dropdownItems,
        onChanged: (newID) {
          // Handle change here
          // get the new materials
          if (newID == "default") {
            materialApi
                .getCourseMaterials("default", currentUser!.departmentID)
                .then((materials) {
              ref.read(currentUserMaterialsProvider.notifier).state = materials;
            }).catchError((e) {
              showSnackBar(context: context, content: e);
            });
            setState(() {
              selectedCourseId = newID;
            });
            log("Selected ID: $newID");
            return;
          }
          materialApi.getCourseMaterials(newID ?? "", "").then((materials) {
            ref.read(currentUserMaterialsProvider.notifier).state = materials;
          }).catchError((e) {
            showSnackBar(context: context, content: e);
          });
          setState(() {
            selectedCourseId = newID;
          });
          log("Selected ID: $newID");
        },
      ),
    );
  }
}
