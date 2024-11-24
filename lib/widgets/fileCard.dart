import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uniarchive/models.dart' as model;

class Filecard extends StatelessWidget {
  final model.Material file;
  const Filecard({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 60,
      decoration: BoxDecoration(
        // color: Colors.blue, // Background color of the container
        border: Border.all(
          // color: Colors.blue, // Border color
          width: 2, // Border width
        ),
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      margin: const EdgeInsets.only(top: 10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(
                Icons.file_present_rounded,
              ),
              onPressed: () {
                // Add search logic here
              },
            ),
            Text(file.name),
            Spacer(), // This will push the following widget to the end of the row

            IconButton(
              icon: const Icon(
                Icons.more_horiz_outlined,
              ),
              onPressed: () {
                // Add search logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
