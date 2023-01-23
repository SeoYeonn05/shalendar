import "package:flutter/material.dart";
import 'package:http/http.dart';
import 'package:shalendar/data/ResponseUser.dart';
import 'package:shalendar/data/user.dart';
import 'package:shalendar/screen/home.dart';
import 'package:shalendar/screen/login.dart';
import '../network/network_helper.dart';
import '../utils/snackbar.dart';
import '../utils/validate.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _networkHelper = NetworkHelper();

  /// 회원가입 버튼을 눌렀을 때 동작
  void registerButton() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      String name = _nameController.text;

      print('회원가입 버튼 눌림 email: $email, password: $password, name: $name');

      // User 클래스 생성하여 http 통신 POST
      var newUser =
          new User(userId: "", email: email, password: password, name: name);
      var result =
          await _networkHelper.post('users/register', newUser.toJson());

      // json 파싱을 통해서 결과 메세지 추출 정상:ok, 값 오류: 메세지, 통신오류 null
      if (result != null) {
        // 결과 메시지 출력
        String resultMsg = ResponseUser.fromJson(result).result;
        if (resultMsg == "ok") {
          showSnackBar(context, "회원가입 완료, 가입한 아이디로 로그인해 주세요."); //스낵바 출력
          // 모든 페이지 제거 후 로그인 화면 이동
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (b) => Login()), (route) => false);
        } else {
          // 회원가입 실패 시 오류메세지 출력
          showSnackBar(context, resultMsg);
        }
      } else {
        // 그 외 오류, 통신오류 발생 시 출력
        showSnackBar(context, "알 수 없는 통신오류가 발생하였습니다.");
      }
    }
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
                SizedBox(height: 30),
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
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'name',
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
                  validator: validateName,
                ),
                SizedBox(height: 30),
                SizedBox(
                  child: OutlinedButton(
                    onPressed: registerButton,
                    child: Text(
                      '회원가입',
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
