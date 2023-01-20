import 'package:flutter/material.dart';
import 'package:shalendar/screen/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 우측 상단 디버그 표시 제거
      debugShowCheckedModeBanner: false,
      home: Home()
    );
  }
}
