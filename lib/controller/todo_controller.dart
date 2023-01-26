import 'package:get/get.dart';
import 'package:shalendar/controller/user_controller.dart';
import 'package:shalendar/data/todo.dart';

import '../network/network_helper.dart';
import '../network/todo_repository.dart';
import '../theme/color.dart';

class TodoController extends GetxController {
  final todoRepo = Get.put(TodoRepository());
  final userController = Get.put(UserController());

  List todoList = [];
  String joinCode = "";
  int theme = int.parse(ColorStyles.themeYellow.value.toString());

  Future<bool> todoIndex(String calendarId) async {
    todoList = [];
    Map? body = await todoRepo.todoIndex(calendarId);
    if (body == null) {
      update();
      return false;
    }
    List todo = body['todos'].map(((e) => Todo.parse(e))).toList();
    todoList = todo;
    update();
    return true;
  }

  Future<bool> loadTheme(String calendarId) async {
    theme = int.parse(await userController.getTheme(int.parse(calendarId)));
    update();
    return true;
  }

  Future<bool> getJoinCode(String calendarId) async {
    Map? body = await todoRepo.getJoinCode(calendarId);
    if (body == null) {
      return false;
    }
    joinCode = body['shareKey'];
    update();
    return true;
  }
}
