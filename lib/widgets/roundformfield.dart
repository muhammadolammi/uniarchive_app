import 'package:flutter/material.dart';

class Roundformfield extends StatelessWidget {
  final String? hintText;
  const Roundformfield({super.key, this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        style: const TextStyle(fontSize: 16), // Adjust text style if needed
        decoration: InputDecoration(
          hintText: hintText ?? "Search here...", // Placeholder text
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30), // Rounded corners
            borderSide: const BorderSide(color: Colors.grey), // Border color
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(30), // Rounded corners when not focused
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(30), // Rounded corners when focused
            borderSide: const BorderSide(
                color: Colors.blue), // Border color when focused
          ),
          fillColor: Colors.grey[400], // Background color of the field
          filled: true, // Enables the fill color
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search logic here
            },
          ),
        ),
      ),
    );
  }
}
