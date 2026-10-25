import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const CampusEventApp());
}

class CampusEventApp extends StatelessWidget {
  const CampusEventApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Event Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'CustomFont', // Custom font applied globally[cite: 2]
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}