import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';

/// 각 탭의 인덱스와 스크린 위젯 매핑
enum BottomItem { calendar, todoList }

const Map<BottomItem, int> tableIndex = {
  BottomItem.calendar: 0,
  BottomItem.todoList: 1
};

Map<BottomItem, Widget> tabScreen = {
/*  BottomItem.calendar: const CalendarScreen(),
  BottomItem.todoList: const TodoListScreen()*/
};

/// 탭 내부 아이콘과 라벨
List<BottomNavigationBarItem> navbarItems = [
  const BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month_outlined),
      label: '캘린더'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.list_alt_outlined),
      label: 'TODO'),
];

class BottomNavigationProvider extends ChangeNotifier {
  late final BottomItem _currentItem;
  late final ValueChanged<BottomItem> onSelectTab;
  get currentItem => _currentItem;

  // page 업데이트
  setCurrentPage(int index) {
    BottomItem.values[index];
    notifyListeners();
  }
}
