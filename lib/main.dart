import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shalendar/screen/home.dart';
import 'package:shalendar/screen/loading.dart';
import 'package:shalendar/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // 저장된 token 불러오기
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');

  runApp(MyApp(token));
}

class MyApp extends StatelessWidget {
  String? token;
  MyApp(this.token, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        // 우측 상단 디버그 표시 제거
        create: (context) {
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: //(token == null) ? Loading() : Home(),
          Loading(),
        ));
  }
}
