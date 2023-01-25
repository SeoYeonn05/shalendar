import 'package:flutter/material.dart';
import 'package:shalendar/data/ResponseWithInsertId.dart';
import 'package:shalendar/network/network_helper.dart';
import 'package:shalendar/controller/user_controller.dart';
import 'package:shalendar/screen/todo.dart';
import 'package:get/get.dart';

/**
 * 선택한 일정의 title을 수정하는 다이얼로그 위젯
 * 생성자 : ChangeTodoDialog(todoId)
 * 생성자에 넣은 todoID에 해당하는 todo의 title을 변경한다.
 */
class ChangeTodoDialog extends StatelessWidget {
  var todoId;
  ChangeTodoDialog(this.todoId, {super.key});

  final changeTodoController = TextEditingController();
  final NetworkHelper networkHelper = NetworkHelper();
  final UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        child: Text('test'),
        onPressed: (() {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return alertDialog(context);
              });
        }));
  }

  Widget alertDialog(BuildContext context) {
    return AlertDialog(
      title: Text('일정 수정'),
      content: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Title',
            ),
            controller: changeTodoController,
          )
        ],
      ),
      actions: [
        // ok button
        OutlinedButton(
            onPressed: () async {
              // make body
              Map<String, dynamic> body = <String, dynamic>{};
              body['title'] = changeTodoController.text;
              // request url
              var url = "calendar/$todoId/todo";
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
                var insertId = ResponseWithResultId.fromJson(result).insertId;
                // 수정 이후에 할 일
                // todo 수정하고 수정한 todo로 이동?
                print('todo 수정 완료');
                Navigator.of(context).pop();
                Get.to(Todo());
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("에러 발생"),
                        content: Text("todo 변경에 실패했습니다."),
                      );
                    });
              }
            },
            child: Text('ok')),
        // cancel
        OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('cancel')),
      ],
    );
  }
}
