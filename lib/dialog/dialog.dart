import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shalendar/provider/home_provider.dart';

import '../controller/user_controller.dart';
import '../data/ResponseUserPost.dart';
import '../network/network_helper.dart';
import '../theme/color.dart';
import '../utils/snackbar.dart';

void dialog(BuildContext context, int type, HomeProvider _homeProvider) async {
  (type == 1)
      ? addCalendarDialog(context, _homeProvider)
      : joinCalendarDialog(context, _homeProvider);
}

// 기본값 themeYellow
String? color = "themeYellow";

// 캘린더 추가 다이얼로그에서 ok 클릭 시
void addCalendar(
    BuildContext context, String? name, HomeProvider _homeProvider) async {
  final userController = Get.put(UserController());
  final _networkHelper = NetworkHelper();

  if (name == null || name!.trim().isEmpty) {
    showSnackBar(context, "캘린더 이름을 입력하세요.");
    return;
  }
  print("캘린더 생성 name : $name, color : $color");
  ResponseUserPost result = await _networkHelper.addCalendar("calendar", name);
  if (result.result == "ok") {
    showSnackBar(context, "캘린더 생성 완료.");
    // 로컬에 테마 저장
    userController.setTheme(result.insertId!, color);
    print("setTheme 로컬에 저장 key : ${result.insertId}, value : $color");
  } else {
    showSnackBar(context, "캘린더 생성 실패.");
  }
  _homeProvider.getCalendar();
}

// 캘린더 참가 다이얼로그에서 ok 클릭 시
void joinCalendar(
    BuildContext context, String? code, HomeProvider _homeProvider) async {
  final userController = Get.put(UserController());
  final _networkHelper = NetworkHelper();

  if (code == null || code!.trim().isEmpty) {
    showSnackBar(context, "참가 코드를 입력하세요.");
    return;
  }
  print("캘린더 참가 code : $code, color : $color");
  ResponseUserPost result = await _networkHelper.joinCalendar(code);
  if (result.result == "ok") {
    showSnackBar(context, "캘린더 참가 완료.");
    userController.setTheme(result.insertId!, color);
    print("setTheme 로컬에 저장 key : ${result.insertId}, value : $color");
  } else {
    showSnackBar(context, result.result);
  }
  _homeProvider.getCalendar();
}

void addCalendarDialog(BuildContext context, HomeProvider _homeProvider) async {
  final _textController = TextEditingController();

  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  child: Text(
                    "캘린더 이름",
                    style: TextStyle(color: Colors.white),
                  ),
                  width: double.infinity,
                ),
                TextField(
                  controller: _textController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
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
                ),
                SizedBox(height: 15),
                SizedBox(
                  child: Text(
                    "테마 설정",
                    style: TextStyle(color: Colors.white),
                  ),
                  width: double.infinity,
                ),
                SizedBox(height: 15),
                ThemeButton(),
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
                    onPressed: () {
                      addCalendar(context, _textController.text, _homeProvider);
                      Navigator.pop(context, 'OK');
                    },
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

void joinCalendarDialog(
    BuildContext context, HomeProvider _homeProvider) async {
  final _textController = TextEditingController();

  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  child: Text(
                    "참가코드 입력",
                    style: TextStyle(color: Colors.white),
                  ),
                  width: double.infinity,
                ),
                TextField(
                  controller: _textController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
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
                ),
                SizedBox(height: 15),
                SizedBox(
                  child: Text(
                    "테마 설정",
                    style: TextStyle(color: Colors.white),
                  ),
                  width: double.infinity,
                ),
                SizedBox(height: 15),
                ThemeButton(),
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
                    onPressed: () {
                      joinCalendar(
                          context, _textController.text, _homeProvider);
                      Navigator.pop(context, 'OK');
                    },
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

class ThemeButton extends StatelessWidget {
  ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: SizedBox(
            height: 28,
            width: 28,
            child: ElevatedButton(
              onPressed: () {
                color = ColorStyles.themeYellow.value.toString();
              },
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyles.themeYellow,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: SizedBox(
            height: 28,
            width: 28,
            child: ElevatedButton(
              onPressed: () {
                color = ColorStyles.themeRed.value.toString();
              },
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyles.themeRed,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: SizedBox(
            height: 28,
            width: 28,
            child: ElevatedButton(
              onPressed: () {
                color = ColorStyles.themePink.value.toString();
              },
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyles.themePink,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: SizedBox(
            height: 28,
            width: 28,
            child: ElevatedButton(
              onPressed: () {
                color = ColorStyles.themeOrange.value.toString();
              },
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyles.themeOrange,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: SizedBox(
            height: 28,
            width: 28,
            child: ElevatedButton(
              onPressed: () {
                color = ColorStyles.themeGreen.value.toString();
              },
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyles.themeGreen,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: SizedBox(
            height: 28,
            width: 28,
            child: ElevatedButton(
              onPressed: () {
                color = ColorStyles.themeBlue.value.toString();
              },
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyles.themeBlue,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: SizedBox(
            height: 28,
            width: 28,
            child: ElevatedButton(
              onPressed: () {
                color = ColorStyles.themeBlack.value.toString();
              },
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyles.themeBlack,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
