import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shalendar/provider/home_provider.dart';
import 'package:shalendar/widget/themeButton.dart';

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
int? color = ColorStyles.themeYellow.value;

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
                  decoration: const InputDecoration(
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
                const SizedBox(height: 15),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "테마 설정",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 15),
                ThemeButton(),
              ],
            ),
          ),
          backgroundColor: ColorStyles.backgroundColor,
          actions: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  TextButton(
                    onPressed: () {
                      addCalendar(context, _textController.text, _homeProvider);
                      Navigator.pop(context, 'OK');
                    },
                    child: const Text(
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
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "참가코드 입력",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextField(
                  controller: _textController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  decoration: const InputDecoration(
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
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "테마 설정",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 15),
                ThemeButton(),
              ],
            ),
          ),
          backgroundColor: ColorStyles.backgroundColor,
          actions: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text(
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
                    child: const Text(
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
