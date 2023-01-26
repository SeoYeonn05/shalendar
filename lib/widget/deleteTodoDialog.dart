import 'package:flutter/material.dart';
import 'package:shalendar/data/ResponseWithInsertId.dart';
import 'package:shalendar/network/network_helper.dart';
import 'package:shalendar/controller/user_controller.dart';
import 'package:shalendar/screen/todo.dart';
import 'package:get/get.dart';
import 'package:shalendar/utils/snackbar.dart';

/**
 * 선택한 일정의 title을 삭제하는 다이얼로그 위젯
 * 생성자 : DeleteTodoDialog(todoId)
 * 생성자에 넣은 todoID에 해당하는 todo를 삭제한다
 */
class DeleteTodoDialog extends StatelessWidget {
  var todoId;
  var todoList;
  var index;
  DeleteTodoDialog(this.todoId, this.todoList, this.index, {super.key});

  final changeTodoController = TextEditingController();
  final NetworkHelper networkHelper = NetworkHelper();
  final UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return alertDialog(context);
  }

  Widget alertDialog(BuildContext context) {
    return AlertDialog(
      title: Text(
        '일정 삭제',
        style: TextStyle(color: Colors.white),
      ),
      content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '선택한 일정을 삭제하시겠습니까?',
              style: TextStyle(color: Colors.white),
            ),
          ]),
      backgroundColor: Color(0xff3E3E3E),
      actions: [
        // ok button
        Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          OutlinedButton(
            child: Text(
              'OK',
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ),
            onPressed: () async {
              // request url
              var url = "todo/$todoId";
              // request headers
              Map<String, String> headers = <String, String>{};
              String? token = await userController.getToken() as String;
              headers['token'] = token;
              // send request
              var result =
                  await networkHelper.deleteWithOnlyHeaders(url, headers);
              print(result);
              // if response is not null
              if (result != null) {
                // get result
                var parsedResult = ResponseWithResultId.fromJson(result).result;
                // 수정 이후에 할 일
                // todo 수정하고 수정한 todo로 이동?
                if (parsedResult == "ok") {
                  print('todo 삭제 완료');
                  Navigator.of(context).pop();
                  todoList.removeAt(index);
                  showSnackBar(context, 'todo 삭제 완료');
                  // Get.to(Todo());
                } else {
                  Navigator.of(context).pop();
                  showSnackBar(context, 'todo 삭제에 실패했습니다.');
                }
              } else {
                Navigator.of(context).pop();
                showSnackBar(context, 'todo 삭제에 실패했습니다.');
              }
            },
          ),
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
            ),
          ),
        ]))
      ],
    );
  }

  Future<dynamic> deleteTodoFailedDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("에러 발생"),
            content: Text("todo 삭제에 실패했습니다."),
          );
        });
  }
}
