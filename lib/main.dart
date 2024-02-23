import 'package:flutter/material.dart';
import 'package:owl_post/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        fontFamily: 'SixtyFour',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey.shade900,
        primaryColor: Colors.grey.shade900,
      ),
    );
  }
}