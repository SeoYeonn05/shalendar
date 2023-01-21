import 'package:flutter/cupertino.dart';

import 'bottom_nav_provider.dart';



class HomeProvider extends ChangeNotifier {
  late BottomNavigationProvider _bottomNavigationProvider;

  final _navigatorKeys = {
    BottomItem.calendar: GlobalKey<NavigatorState>(),
    BottomItem.todoList: GlobalKey<NavigatorState>()
  };

  void _selectTab(BottomItem btmItem){
    if(btmItem == _bottomNavigationProvider.onSelectTab){
      /// 네비게이션 탭을 누르면, 해당 네비의 첫 스크린으로 이동
      _navigatorKeys[btmItem]!.currentState!.popUntil((route) => route.isFirst);
    } else{

    }
  }
}