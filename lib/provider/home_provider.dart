import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shalendar/data/Calendar.dart';
import 'package:shalendar/network/network_helper.dart';
import 'package:http/http.dart' as http;
import 'bottom_nav_provider.dart';


enum HomeState{
  loading, empty, completed
}


class HomeProvider extends ChangeNotifier {
  late HomeState state = HomeState.loading;
  late List<Calendar> calendarList;
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
    try {
      http.Response response = await http.get(Uri.parse('http://http://ec2-43-201-53-135.ap-northeast-2.compute.amazonaws.com//calendar'));

      if (response.statusCode == 200) {
        // User.fromJson(json.decode(response.body)) 형태로 사용
        Calendar.fromJson(json.decode(response.body));
        state = HomeState.completed;
      } else {
        state = HomeState.empty;
        return null;
      }
      notifyListeners();
    } catch (e) {
      return null;
    }
  }

}