import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shalendar/controller/user_controller.dart';
import 'package:shalendar/data/calendar.dart';
import 'package:shalendar/network/network_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../data/todo.dart';
import '../data/user.dart';
import '../network/todo_repository.dart';
import 'bottom_nav_provider.dart';

enum HomeState { loading, empty, calendarCompleted, a, infoCompleted }

class HomeProvider extends ChangeNotifier {
  late HomeState state = HomeState.loading;
  late List<Calendar>? calendarList;
  late List<Todo>? todoList;
  late Map<int, int> themeMap;
  late Map<String, String> calUserName={};
  late Map<String, int> calUserCount={};
  late Map<String, double> completeRate={};



  setState(currentState) {
    state = currentState;
    notifyListeners();
  }

  var logger = Logger(printer: PrettyPrinter());

  final _navigatorKeys = {
    BottomItem.calendar: GlobalKey<NavigatorState>(),
    BottomItem.todoList: GlobalKey<NavigatorState>()
  };

/*  void _selectTab(BottomItem btmItem){
    if(btmItem == bottomNavigationProvider.onSelectTab){
      /// 네비게이션 탭을 누르면, 해당 네비의 첫 스크린으로 이동
      _navigatorKeys[btmItem]!.currentState!.popUntil((route) => route.isFirst);
    } else{
    }
  }*/


  Future getCalendar() async {
    final NetworkHelper networkHelper = NetworkHelper();
    final UserController userController = Get.put(UserController());

    calendarList = [];
    themeMap = <int, int>{};
    try {
      Map<String, String> headers = <String, String>{};
      var token = (await userController.getToken())!;
      headers['token'] = token;
      Map<String, Object?> response =
      await networkHelper.getWithHeaders("calendar", headers);
      Object? founded = response['calendars'];

      // logger.d(calendars);
      // logger.d(founded.runtimeType);

      if (founded != null) {
        logger.d('home provider 실행');
        // User.fromJson(json.decode(response.body)) 형태로 사용

        founded = founded as List;
        for (var calendar in founded) {
          Map<String, dynamic> tmp = calendar;

          Calendar res = Calendar(
              calendarId: tmp['calendar_id'].toString(),
              calendarName: tmp['calendar_name'],
              createdAt: DateTime.parse(tmp['created_at']),
              userConnId: tmp['user_conn_id']);

          calendarList?.add(res);

          themeMap[tmp['calendar_id']] = await userController.getTheme(tmp['calendar_id']);
        }
        state = HomeState.calendarCompleted;
        notifyListeners();
      } else {
        state = HomeState.empty;
        return null;
      }
      notifyListeners();
    } catch (e) {
      //logger.d(e);
      return null;
    }
  }

  // 성취도 계산
  Future getAchievementRate() async{
    int count=0;
    int completeCount=0;
    List result = [];
    List todoList = [];
    final todoRepo = Get.put(TodoRepository());

    if(calendarList == null){
      return null;
    }

    logger.d('안녕 todo?');

    for (var cal in calendarList!!){
      // 캘린더에 속해있는 할 일들을 검색
      var calId = cal.calendarId;
      count = 0;
      completeCount = 0;

      Map? body = await todoRepo.todoIndex(calId!);

      if (body == null) {
        completeRate[cal.calendarId!] = 0;
        continue;
      }

      List todo = body['todos'].map(((e) => Todo.parse(e))).toList();
      todoList = todo;

      logger.d('todoList $todoList');

      for (var todo in todoList) {
        count++;

        Todo res = todo;

        logger.d('todo: $res');

        if(res.isComplete!!){
          completeCount++;
        }

        logger.d("퍼센트는 ${completeCount/count * 100}");
        completeRate[cal.calendarId!] = completeCount/count * 100;
      }
    }
    state = HomeState.a;
    notifyListeners();
  }

  Future getCalUser(String calId) async{
    List userList = [];
    final todoRepo = Get.put(TodoRepository());

    Map? response = await todoRepo.getCalendartUser(calId);

    if (response == null) {
      return null;
    }

    userList = response['users'];
    //logger.d("homeProvider $userList");

    return userList;
  }

  Future<void> getInform() async{
    int count=0;
    List userList = [];
    String? currentName;

    logger.d('안녕 user?');

    try{
      if(calendarList == null){
        return;
      }
      for (var cal in calendarList!!){
        count = 0;
        //logger.d("getInfo calendarList: $calendarList");
        var calId = cal.calendarId;
        userList = await getCalUser(calId!!);

        Map<String, dynamic> tmp = userList[0];
        currentName = tmp['user_name'];

        for (var user in userList) {
          count++;
        }

        calUserCount[calId] = count;
        calUserName[calId] = currentName!!;
      }
      state = HomeState.infoCompleted;
      notifyListeners();

    } catch(e){
      state = HomeState.empty;
    }
  }
}