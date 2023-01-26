import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shalendar/screen/loading.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        // 우측 상단 디버그 표시 제거
        create: (context) {},
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: Loading(),
        ));
  }
}
