import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniarchive/providers/provider.dart';

class CoursesDropdown extends ConsumerStatefulWidget {
  const CoursesDropdown({super.key});

  @override
  ConsumerState<CoursesDropdown> createState() => _CoursesDropdownState();
}

class _CoursesDropdownState extends ConsumerState<CoursesDropdown> {
  @override
  Widget build(BuildContext context) {
    final courses = ref.watch(currentUserCoursesProvider);
    String? selectedCourseId; // Holds the selected course ID

    if (courses == null || courses.isEmpty) {
      // Handle the null or empty state
      return const Text("No courses available");
    }

    return DropdownButton(
      hint: Text('Default'),
      value: selectedCourseId,
      isExpanded: true,
      items: courses.map((course) {
        return DropdownMenuItem<String>(
          value: course.id, // Value to be selected
          child: Text(course.courseCode), // Displayed text
        );
      }).toList(),
      onChanged: (newID) {
        // Handle change here
        setState(() {
          selectedCourseId = newID;
        });
        log("Selected ID: $newID");
      },
    );
  }
}