import 'package:flutter/material.dart';
import 'package:nbaapiapp/screens/home_screen.dart';

void main() => runApp(const NbaApp());

class NbaApp extends StatelessWidget {
  const NbaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NBA API',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEDF2F6),
      ),
      home: HomeScreen(),
    );
  }
}
