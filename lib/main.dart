import 'package:flutter/material.dart';
import 'login_page.dart';


void main() {
  runApp(AstrologyApp());
}

class AstrologyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Astrology App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
