import 'package:flutter/material.dart';
import 'package:shalendar/controller/todo_controller.dart';
import 'package:shalendar/data/ResponseWithInsertId.dart';
import 'package:shalendar/network/network_helper.dart';
import 'package:shalendar/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:shalendar/utils/snackbar.dart';

/**
 * 선택한 일정의 title을 생성하는 다이얼로그 위젯
 * 생성자 : AddTodoDialog(calendarId)
 * 생성자에 넣은 calendarId에 해당하는 calendar에 todo를 추가한다
 */
class AddTodoDialog extends StatelessWidget {
  var calendarId;
  var createdAt;
  AddTodoDialog(this.calendarId, this.createdAt, {super.key});

  final addTodoController = TextEditingController();
  final NetworkHelper networkHelper = NetworkHelper();
  final UserController userController = Get.put(UserController());
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return alertDialog(context);
  }

  Widget alertDialog(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            child: Text(
              "일정 추가",
              style: TextStyle(color: Colors.white),
            ),
            width: double.infinity,
          ),
          TextField(
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
            controller: addTodoController,
          )
        ],
      ),
      backgroundColor: Color(0xff3E3E3E),
      actions: [
        // ok button
        Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            OutlinedButton(
                onPressed: () async {
                  // make body
                  Map<String, dynamic> body = <String, dynamic>{};
                  body['title'] = addTodoController.text;
                  body['created_at'] =
                      "${createdAt.year}-${createdAt.month}-${createdAt.day} ${createdAt.hour}:${createdAt.minute}:${createdAt.second}";
                  // request url
                  var url = "calendar/$calendarId/todo";
                  // request headers
                  Map<String, String> headers = <String, String>{};
                  String? token = await userController.getToken() as String;
                  headers['token'] = token;
                  // send request
                  var result =
                      await networkHelper.postWithHeaders(url, headers, body);

                  // if response is not null
                  if (result != null) {
                    // get changed todo id
                    var insertId =
                        ResponseWithResultId.fromJson(result).insertId;
                    // 수정 이후에 할 일
                    // todo 수정하고 수정한 todo로 이동?
                    print('todo 생성 완료');
                    Navigator.of(context).pop();
                    todoController.todoIndex(calendarId);
                    todoController.todoDayIndex(calendarId, createdAt);
                    showSnackBar(context, 'todo 생성 완료');
                  } else {
                    Navigator.of(context).pop();
                    showSnackBar(context, 'todo 생성에 실패했습니다');
                  }
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                )),
            SizedBox(width: 30),
            // cancel
            OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                )),
          ]),
        ),
      ],
    );
  }
}
