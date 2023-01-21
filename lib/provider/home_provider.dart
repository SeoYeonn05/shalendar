import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shalendar/data/Calendar.dart';

import 'bottom_nav_provider.dart';


enum HomeState{
  loading, empty, completed
}


class HomeProvider extends ChangeNotifier {
  late BottomNavigationProvider bottomNavigationProvider;
  late HomeState state;
  late List<Calendar> calendarList;

  final _navigatorKeys = {
    BottomItem.calendar: GlobalKey<NavigatorState>(),
    BottomItem.todoList: GlobalKey<NavigatorState>()
  };

  void _selectTab(BottomItem btmItem){
    if(btmItem == bottomNavigationProvider.onSelectTab){
      /// 네비게이션 탭을 누르면, 해당 네비의 첫 스크린으로 이동
      _navigatorKeys[btmItem]!.currentState!.popUntil((route) => route.isFirst);
    } else{

    }
  }

  void getCalendarList(){

  }
}