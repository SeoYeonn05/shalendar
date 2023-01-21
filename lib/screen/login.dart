import "package:flutter/material.dart";
import 'package:shalendar/screen/register.dart';
import '../utils/validate.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  /// 로그인 버튼을 눌렀을 때 동작
  void loginButton() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      print('로그인 버튼 눌림 email: $email, password: $password');
      // 서버통신 부분

      // 로그인 된 페이지로 이동
      // Navigator.pushAndRemoveUntil(
      //     context, MaterialPageRoute(builder: (b) => Home()), (route) => false);

    }
  }

  /// 회원가입 화면으로 이동
  void goToRegister() async {
    print('회원가입 화면으로 이동');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (b) => Register()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3E3E3E),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  child: Image.asset('assets/icons/logo_white.png'),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                ),
                SizedBox(height: 50),
                TextFormField(
                  controller: _emailController,
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
                  validator: validateEmail,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
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
                  validator: validatePassword,
                ),
                Row(
                  children: [
                    Expanded(child: SizedBox()),
                    TextButton(
                      onPressed: goToRegister,
                      child: Text(
                        '회원가입',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  child: OutlinedButton(
                    onPressed: loginButton,
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
