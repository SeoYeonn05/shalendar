import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../provider/bottom_nav_provider.dart';
import '../provider/home_provider.dart';
import '../widget/bottom_nav.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late ConnectivityResult connectivityResult;

  @override
  void initState() {
    super.initState();

    // 인터넷 검사
    Connectivity()
        .checkConnectivity()
        .then((value) => connectivityResult = value);

    // 유저 초기 설정

  }

// 로딩페이지와 동시에 사용
  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (/*_authProvider.user != null*/ true) { /// 로그인이 되었는지 확인
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
        if (connectivityResult == ConnectivityResult.none) {
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
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.white.withOpacity(1.0),
                    ])),
            child: Container(
                margin: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        width: 140.0,
                        height: 100.0,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                AssetImage('assets/icons/logo_black.png')),
                            color: Colors.transparent)),
                      ],
                  )
                )));
  }
}
