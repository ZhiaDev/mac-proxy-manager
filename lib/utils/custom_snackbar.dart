import 'package:flutter/material.dart';

class CustomSnackBar {
  // Show a green-colored SnackBar with the specified content
  static void green(BuildContext context, {required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        content,
        style: const TextStyle(color: Colors.green),
      ),
      // Set SnackBar background color
      backgroundColor: const Color(0xFF130E36),
    ));
  }

  // Show a red-colored SnackBar with the specified content
  static void red(BuildContext context, {required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        content,
        style: const TextStyle(color: Colors.red),
      ),
      // Set SnackBar background color
      backgroundColor: const Color(0xFF130E36),
    ));
  }
}
