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
  List todoDayList = [];
  List userList = [];
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

  Future<bool> todoDayIndex(String calendarId, DateTime date) async {
    todoDayList = [];
    Map? body = await todoRepo.todoIndex(calendarId);
    if (body == null) {
      update();
      return false;
    }
    List todo = body['todos'].map(((e) => Todo.parse(e))).toList();
    todoList = todo;

    todoDayList = todoList
        .where((e) => (e.createdAt?.year == date.year &&
            e.createdAt?.month == date.month &&
            e.createdAt?.day == date.day))
        .toList();
    update();
    return true;
  }

  Future<bool> loadTheme(String calendarId) async {
    theme = (await userController.getTheme(int.parse(calendarId)));
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

  Future<bool> getCalendartUser(String calendarId) async {
    Map? body = await todoRepo.getCalendartUser(calendarId);
    if (body == null) {
      return false;
    }
    userList = body['users'];
    update();
    return true;
  }

  Future<bool> unsharedCalendar(String calendarId) async {
    Map? body = await todoRepo.unsharedCalendar(calendarId);
    if (body == null) {
      return false;
    }
    return true;
  }
}
