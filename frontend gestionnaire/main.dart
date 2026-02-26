import 'package:admin/LandingPage.dart';
import 'package:flutter/material.dart';

import 'LandingPage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF19BDAB)),
      ),
      home: LandingPage(), //
      debugShowCheckedModeBanner: false,
    );
  }
}
