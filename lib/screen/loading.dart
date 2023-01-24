import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/bottom_nav_provider.dart';
import '../provider/home_provider.dart';
import '../widget/bottom_nav.dart';
import 'login.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late ConnectivityResult connectivityResult;
  String? token;

  @override
  void initState() {
    super.initState();

    // 인터넷 검사
    Connectivity()
        .checkConnectivity()
        .then((value) => connectivityResult = value);

  }

  void getToken() async{
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
  }

// 로딩페이지와 동시에 사용
  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(milliseconds: 1500), () {
      if ( token != null) { /// 로그인이 되었는지 확인
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MultiProvider(providers: [
                  ChangeNotifierProvider(
                      create: (context) => BottomNavigationProvider()),
                  ChangeNotifierProvider(
                      create: (context) => HomeProvider()),
                ], child: BottomNavigation())),
                (route) => false);
      } else {
        if(connectivityResult == ConnectivityResult.none){
          Fluttertoast.showToast(
              msg: "wifi 상태를 확인해주세요", toastLength: Toast.LENGTH_SHORT);
        }
      }
    });

    return Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
/*        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/img_loading.png'),
              fit: BoxFit.cover),
        ),*/
        child: const MaterialApp(
          home: Login()
        )
    );
  }
}
