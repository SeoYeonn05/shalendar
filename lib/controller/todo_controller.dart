import 'package:get/get.dart';
import 'package:shalendar/data/todo.dart';

import '../network/network_helper.dart';
import '../network/todo_repository.dart';

class TodoController extends GetxController {
  final todoRepo = Get.put(TodoRepository());
  List todoList = [];

  Future<bool> todoIndex(String calendarId) async {
    Map? body = await todoRepo.todoIndex(calendarId);
    if (body == null) {
      return false;
    }
    List todo = body['todos'].map(((e) => Todo.parse(e))).toList();
    todoList = todo;
    update();
    return true;
  }
}
