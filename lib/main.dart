import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shalendar/provider/loading_provider.dart';
import 'package:shalendar/screen/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // 우측 상단 디버그 표시 제거
      create: (context) => LoadingProvider(),
      child: const MaterialApp(home: Home())
    );
  }
}
