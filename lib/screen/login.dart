import "package:flutter/material.dart";
import 'package:shalendar/screen/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/ResponseUser.dart';
import '../data/user.dart';
import '../network/network_helper.dart';
import '../utils/snackbar.dart';
import '../utils/validate.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _networkHelper = NetworkHelper();

  /// 로그인 버튼을 눌렀을 때 동작
  void loginButton() async {
    final prefs = await SharedPreferences.getInstance();

    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      print('로그인 버튼 눌림 email: $email, password: $password');
      // 서버통신 부분

      // User 클래스 생성하여 http 통신 POST
      var newUser =
          new User(userId: "", email: email, password: password, name: "");
      var result = await _networkHelper.post('users/login', newUser.toJson());

      // json 파싱을 통해서 결과 메세지 추출 정상:ok, 값 오류: 메세지, 통신오류 null
      if (result != null) {
        // 결과 메시지 출력
        String resultMsg = ResponseUser.fromJson(result).result;
        if (resultMsg == "ok") {
          String? token = ResponseUser.fromJson(result).token;
          showSnackBar(context, "로그인 완료"); //스낵바 출력

          // token이 있을 경우
          if (token != null) {
            await prefs.setString('token', token);

            // 로그인 된 페이지로 이동
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (b) => Home()), (route) => false);
          }
        } else {
          // 로그인 실패 시 오류메세지 출력
          showSnackBar(context, "Email 혹은 password가 틀립니다.");
        }
      } else {
        // 그 외 오류, 통신오류 발생 시 출력
        showSnackBar(context, "알 수 없는 통신오류가 발생하였습니다.");
      }
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
