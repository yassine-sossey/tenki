// **************بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيم***************
// Tenki is a weather forecast App
import 'package:flutter/material.dart';
import 'package:tenki/screens/loading_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: const LoadingScreen(),
    );
  }
}
