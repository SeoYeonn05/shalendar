import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:shalendar/data/ResponseUserGet.dart';
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
    // 회원탈퇴 다이얼로그 출력 후 확인되면
    // 토큰 삭제, 회원 삭제, 로그인 화면으로 이동
  }

  // 회원 정보 갱신
  void getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    User result = await _networkHelper.getUser("users", token);
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
      backgroundColor: Color(0xff3E3E3E),
      appBar: AppBar(
        title: Image.asset(
          'assets/icons/logo_white.png',
          fit: BoxFit.contain,
          height: 38,
        ),
        centerTitle: true,
        backgroundColor: Color(0xff676767),
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
              onPressed: deleteUser,
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
