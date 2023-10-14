import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

// The main entry point of the application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Disable debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Set the default text font to Google Fonts 'Poppins'
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        // Enable Material 3 design
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          // Define the color scheme for the app
          seedColor: Colors.indigo, // Base color for the color scheme
          brightness: Brightness.dark, // Use a dark color scheme
        ),
      ),
      // Set the home page as HomePage with a title 'Proxy Manager'
      home: const HomePage(title: 'Proxy Manager'),
    );
  }
}
