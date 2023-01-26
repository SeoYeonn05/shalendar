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
import 'package:shalendar/theme/color.dart';
import 'bottom_nav_provider.dart';

enum HomeState { loading, empty, completed }

class HomeProvider extends ChangeNotifier {
  late HomeState state = HomeState.loading;
  late List<Calendar>? calendarList;
  late Map<int, int> themeMap;
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
        logger.d('hi');
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
          themeMap[tmp['calendar_id']] =
              await userController.getTheme(tmp['calendar_id']);
          // themeMap![tmp['calendar_id']] = Color(
          //     int.parse(()));
        }
        state = HomeState.completed;
      } else {
        state = HomeState.empty;
        return null;
      }
      notifyListeners();
    } catch (e) {
      logger.d(e);
      return null;
    }
  }
}
