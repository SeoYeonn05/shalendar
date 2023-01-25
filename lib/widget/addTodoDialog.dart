import 'package:flutter/material.dart';
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
  AddTodoDialog(this.calendarId, {super.key});

  final addTodoController = TextEditingController();
  final NetworkHelper networkHelper = NetworkHelper();
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        // 다이얼로그를 불러올 테스트 버튼
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
      title: Text('일정 생성'),
      content: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Title',
            ),
            controller: addTodoController,
          )
        ],
      ),
      actions: [
        // ok button
        OutlinedButton(
            onPressed: () async {
              // make body
              Map<String, dynamic> body = <String, dynamic>{};
              body['title'] = addTodoController.text;
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
                var insertId = ResponseWithResultId.fromJson(result).insertId;
                // 수정 이후에 할 일
                // todo 수정하고 수정한 todo로 이동?
                print('todo 생성 완료');
                Navigator.of(context).pop();
                showSnackBar(context, 'todo 생성 완료');
              } else {
                Navigator.of(context).pop();
                showSnackBar(context, 'todo 생성에 실패했습니다');
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