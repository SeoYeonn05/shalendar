import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:shalendar/data/ResponseUserGet.dart';
import 'package:shalendar/theme/color.dart';
import 'package:shalendar/utils/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/user.dart';
import '../network/network_helper.dart';
import '../provider/home_provider.dart';
import 'login.dart';

class User_Setting extends StatefulWidget {
  const User_Setting({super.key});

  @override
  State<User_Setting> createState() => _User_SettingState();
}

class _User_SettingState extends State<User_Setting> {
  final _networkHelper = NetworkHelper();
  String? token;
  String userEmail = "";

  /// 뒤로가기 버튼 눌렀을 때
  void backButton() {
    Navigator.pop(context);
  }

  /// 로그아웃 버튼 눌렀을 때
  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove('token');

    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (b) => Login()), (route) => false);
  }

  /// 회원탈퇴 버튼 눌렀을 때
  void deleteUser() async {
    // 토큰 삭제, 회원 삭제, 로그인 화면으로 이동
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    var result = await _networkHelper.deleteUser("users");

    if (result == "ok") {
      showSnackBar(context, "회원 탈퇴가 완료되었습니다.");
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (b) => Login()), (route) => false);
    }
  }

  void askDeleteUser() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "회원 탈퇴",
              style: TextStyle(color: Colors.white),
            ),
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    child: Text(
                      "회원 탈퇴를 진행하시겠습니까?",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Color(0xff3E3E3E),
            actions: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    TextButton(
                      onPressed: deleteUser,
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  // 회원 정보 갱신
  void getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    User result = await _networkHelper.getUser("users");
    if (result.email != null) {
      userEmail = result.email!;
    }
    print(userEmail);
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.backgroundColor,
      appBar: AppBar(
        title: Image.asset(
          'assets/icons/logo_white.png',
          fit: BoxFit.contain,
          height: 38,
        ),
        centerTitle: true,
        backgroundColor: ColorStyles.appbarColor,
        leading: IconButton(
            onPressed: backButton,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: ListView(
        children: [
          Container(
            height: 50,
            child: OutlinedButton(
              onPressed: null,
              style: OutlinedButton.styleFrom(
                backgroundColor: Color(0xff797979),
                side: BorderSide(
                  color: Color(0xff797979),
                  width: 0.2,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0))),
              ),
              child: Row(
                children: [
                  Text(
                    "계정 관리",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            child: OutlinedButton(
              onPressed: null,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Color(0xff797979),
                  width: 0.2,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0))),
              ),
              child: Row(
                children: [
                  Text(
                    "로그인 정보 : ${userEmail}",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            child: OutlinedButton(
              onPressed: logout,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Color(0xff797979),
                  width: 0.2,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0))),
              ),
              child: Row(
                children: [
                  Text(
                    "로그아웃",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            child: OutlinedButton(
              onPressed: askDeleteUser,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Color(0xff797979),
                  width: 0.2,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0))),
              ),
              child: Row(
                children: [
                  Text(
                    "회원 탈퇴",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 118, 118),
                        fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
