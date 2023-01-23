import "package:flutter/material.dart";

class User_Setting extends StatefulWidget {
  const User_Setting({super.key});

  @override
  State<User_Setting> createState() => _User_SettingState();
}

class _User_SettingState extends State<User_Setting> {
  /// 뒤로가기 버튼 눌렀을 때
  void backButton() {}

  /// 로그아웃 버튼 눌렀을 때
  void logout() {}

  /// 회원탈퇴 버튼 눌렀을 때
  void deleteUser() {}

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
                    "로그인 정보 : z@z.zz",
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
