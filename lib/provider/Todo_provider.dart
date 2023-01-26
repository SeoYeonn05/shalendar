import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shalendar/controller/todo_controller.dart';
import 'package:shalendar/controller/user_controller.dart';
import 'package:shalendar/data/todo.dart';
import 'package:shalendar/network/network_helper.dart';

class TodoProvider extends ChangeNotifier {
  final List<Todo>? todoList = [];
  final Map<int, int> themeMap = <int, int>{};
  final calendarName = "";

  var logger = Logger(printer: PrettyPrinter());

  Future getTodoListByUser() async {
    final NetworkHelper networkHelper = Get.put(NetworkHelper());
    final UserController userController = Get.put(UserController());

    try {
      todoList?.clear();
      themeMap.clear();
      String requestUrl = "users/todo";
      Map<String, String> headers = <String, String>{};
      headers['token'] = (await userController.getToken())!;
      Map<String, Object?> body =
          await networkHelper.getWithHeaders(requestUrl, headers);
      Object? todos = body['todos'];
      todos = todos as List;
      for (var todo in todos) {
        Map<String, dynamic> tmp = todo;
        Todo newTodo = Todo(
          todoId: tmp['todo_id'],
          title: tmp['title'],
          createdAt: DateTime.parse(tmp['created_at']),
          calendarId: tmp['calendar_id'].toString(),
          isComplete: (tmp['isComplete'] == 1),
        );
        todoList?.add(newTodo);
        themeMap[tmp['calendar_id']] =
            await userController.getTheme(tmp['calendar_id']);
      }
      // todoList 날짜 순으로 정렬
      todoList!.sort((a, b) => a.createdAt!.millisecondsSinceEpoch
          .compareTo(b.createdAt!.millisecondsSinceEpoch));
      notifyListeners();
    } catch (e) {
      logger.d(e);
      return null;
    }
  }

  Future getTodoListByCalendar(int calendarId, DateTime date) async {
    final NetworkHelper networkHelper = Get.put(NetworkHelper());
    final UserController userController = Get.put(UserController());

    try {
      todoList?.clear();
      themeMap.clear();
      String requestUrl = "calendar/$calendarId/todo";
      Map<String, String> headers = <String, String>{};
      headers['token'] = (await userController.getToken())!;
      Map<String, Object?> body =
          await networkHelper.getWithHeaders(requestUrl, headers);
      Object? todos = body['todos'];
      todos = todos as List;
      for (var todo in todos) {
        Map<String, dynamic> tmp = todo;
        Todo newTodo = Todo(
          todoId: tmp['todo_id'],
          title: tmp['title'],
          createdAt: DateTime.parse(tmp['created_at']),
          calendarId: tmp['calendar_id'].toString(),
          isComplete: (tmp['isComplete'] == 1),
        );
        if (newTodo.createdAt?.year == date.year &&
            newTodo.createdAt?.month == date.month &&
            newTodo.createdAt?.day == date.day) {
          todoList?.add(newTodo);
        }
        themeMap[tmp['calendar_id']] =
            await userController.getTheme(tmp['calendar_id']);
      }
      notifyListeners();
    } catch (e) {
      logger.d(e);
      return null;
    }
  }

  Future changeTodoCompleteState(int todoId) async {
    final NetworkHelper networkHelper = Get.put(NetworkHelper());
    final UserController userController = Get.put(UserController());

    String requestUrl = 'api/todo/$todoId';
    Map<String, String> headers = <String, String>{};
    headers['token'] = (await userController.getToken())!;
    Map<String, Object?> result =
        await networkHelper.getWithHeaders(requestUrl, headers);

    if (result['result'] == "ok") {
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
