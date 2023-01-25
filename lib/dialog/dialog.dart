import 'package:flutter/material.dart';

Future<bool> dialog(BuildContext context, int type) async {
  return (type == 1) ? addCalendarDialog(context) : joinCalendarDialog(context);
}

// 캘린더 추가 다이얼로그에서 ok 클릭 시
void addCalendar() {}

// 캘린더 참가 다이얼로그에서 ok 클릭 시
void joinCalendar() {}

Future<bool> addCalendarDialog(BuildContext context) async {
  return await showDialog(
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
                  // controller: _textController,
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

Future<bool> joinCalendarDialog(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('참가 코드 입력'),
          content: Text('정말 삭제하시겠습니까'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
              },
              child: Text('OK'),
            ),
          ],
        );
      });
}

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

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
              onPressed: () {},
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFFD6D6),
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
              onPressed: () {},
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffF5FFBB),
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
              onPressed: () {},
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffEAC7FF),
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
              onPressed: () {},
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffC1F4FF),
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
              onPressed: () {},
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffBBFFCA),
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
              onPressed: () {},
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFFDDAB),
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
              onPressed: () {},
              child: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffB1B1B1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
