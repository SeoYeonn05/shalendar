import "package:flutter/material.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3E3E3E),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Form(
            child: Column(
              children: [
                Container(
                  child: Image.asset('assets/icons/logo_white.png'),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                ),
                SizedBox(height: 50),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  cursorColor: Colors.white,
                  validator: (String? value) {
                    if (value == null || value!.trim().isEmpty) {
                      return "이름을 입력해야 합니다.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  cursorColor: Colors.white,
                  validator: (String? value) {
                    if (value == null || value!.trim().isEmpty) {
                      return "비밀번호를 입력해야 합니다.";
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(child: SizedBox()),
                    TextButton(
                      onPressed: () {
                        // 회원 가입 버튼 클릭 했을 경우 동작
                      },
                      child: Text(
                        '회원가입',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  child: OutlinedButton(
                    onPressed: () {
                      // 로그인 버튼 클릭 했을 경우 동작
                    },
                    child: Text(
                      '로그인',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 1.3, color: Colors.white),
                    ),
                  ),
                  width: double.infinity,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
