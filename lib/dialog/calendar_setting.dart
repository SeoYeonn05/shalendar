import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shalendar/data/calendar.dart';
import 'package:shalendar/provider/home_provider.dart';
import 'package:shalendar/screen/loading.dart';

import '../controller/todo_controller.dart';
import '../controller/user_controller.dart';
import '../data/ResponseUserPost.dart';
import '../network/network_helper.dart';
import '../theme/color.dart';
import '../utils/snackbar.dart';
import '../widget/calendarUser.dart';

int color = 0;
String joinCode = "";

/// 참가 코드 복사 버튼을 눌렀을 때, 코드를 클립보드에 저장
void joinCodeCopy(BuildContext context, String code) async {
  Clipboard.setData(ClipboardData(text: code));
  showSnackBar(context, "참가 코드가 복사되었습니다.");
  return;
}

// 캘린더 추가 다이얼로그에서 ok 클릭 시
void settingComplete(BuildContext context, Calendar calendar) async {
  final userController = Get.put(UserController());
  final todoController = Get.put(TodoController());

  // 로컬에 테마 저장
  userController.setTheme(int.parse(calendar.calendarId!), color);
  todoController.loadTheme(calendar.calendarId!); // 즉시 반영
}

/// 다이얼로그 출력
void calendarSettingDialog(BuildContext context, Calendar calendar) async {
  final todoController = Get.put(TodoController());
  final userController = Get.put(UserController());

  // 참가 코드 불러오기
  await todoController.getJoinCode(calendar.calendarId!);
  // 저장된 테마색 불러오기
  color = await userController.getTheme(int.parse(calendar.calendarId!));
  // 캘린더에 참여하고 있는 유저 목록 불러오기
  bool result = await todoController.getCalendartUser(calendar.calendarId!);

  if (todoController.joinCode == null) {
    return;
  } else {
    joinCode = todoController.joinCode;
  }

  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  child: Text(
                    "캘린더 이름",
                    style: TextStyle(color: Colors.white),
                  ),
                  width: double.infinity,
                ),
                SizedBox(height: 10),
                SizedBox(
                  child: Text(
                    "${calendar.calendarName}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  width: double.infinity,
                ),
                SizedBox(height: 15),
                SizedBox(
                  child: Text(
                    "참가 코드",
                    style: TextStyle(color: Colors.white),
                  ),
                  width: double.infinity,
                ),
                SizedBox(height: 10),
                SizedBox(
                  child: SingleChildScrollView(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            "${joinCode}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            joinCodeCopy(context, joinCode);
                          },
                          child: Text(
                            "복사",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  width: double.infinity,
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(
                  child: Text(
                    "테마 설정",
                    style: TextStyle(color: Colors.white),
                  ),
                  width: double.infinity,
                ),
                SizedBox(height: 15),
                ThemeButton(),
                SizedBox(height: 15),
                SizedBox(
                  child: Text(
                    "참가 인원",
                    style: TextStyle(color: Colors.white),
                  ),
                  width: double.infinity,
                ),
                SizedBox(height: 15),
                Container(
                  width: 300,
                  height: 150,
                  child: ListView.separated(
                    itemBuilder: (context, index) => CalendarUsers(
                        todoController.userList[index]['user_name']),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: todoController.userList.length,
                  ),
                )
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
                    onPressed: () => askDeleteCalendar(context, calendar),
                    child: Text(
                      '캘린더 탈퇴',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 100, 100),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
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
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      settingComplete(context, calendar);
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

/// 회원탈퇴 버튼 눌렀을 때
void deleteCalendar(BuildContext context, Calendar calendar) async {
  final todoController = Get.put(TodoController());
  final userController = Get.put(UserController());

  // 삭제 통신
  bool result = await todoController.deleteCalendartUser(calendar.calendarId!);

  // 성공시 화면 이동, 스낵바 출력, 로컬에 데이터 삭제
  if (result) {
    showSnackBar(context, "캘린더 그룹에서 나가셨습니다.");
    userController.deleteTheme(int.parse(calendar.calendarId!));
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (b) => Loading()), (route) => false);
  } else {
    showSnackBar(context, "오류가 발생하였습니다.");
  }
}

void askDeleteCalendar(BuildContext context, Calendar calendar) async {
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "캘린더 탈퇴",
            style: TextStyle(color: Color.fromARGB(255, 255, 100, 100)),
          ),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  child: Text(
                    "캘린더 그룹을 나가시겠습니까?",
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
                    onPressed: () => deleteCalendar(context, calendar),
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
                color = ColorStyles.themeYellow.value;
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
                color = ColorStyles.themeRed.value;
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
                color = ColorStyles.themePink.value;
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
                color = ColorStyles.themeOrange.value;
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
                color = ColorStyles.themeGreen.value;
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
                color = ColorStyles.themeBlue.value;
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
                color = ColorStyles.themeBlack.value;
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
