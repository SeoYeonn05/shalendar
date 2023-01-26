import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shalendar/screen/user_setting.dart';
import '../provider/bottom_nav_provider.dart';
import '../screen/home.dart';
import '../screen/todo.dart';
import '../theme/color.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({Key? key}) : super(key: key);
  late BottomNavigationProvider _bottomNavigationProvider;

  @override
  Widget build(BuildContext context) {
    _bottomNavigationProvider = Provider.of<BottomNavigationProvider>(context);
    const Color unSelected = Color.fromRGBO(204, 210, 223, 1);
    const Color selected = Colors.white;
    const EdgeInsets itemPadding = EdgeInsets.fromLTRB(0, 8, 0, 5);

/*    [
      const BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          label: '캘린더'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_outlined),
          label: 'TODO'),
    ];*/

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
            backgroundColor: ColorStyles.appbarColor,
            title: Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/icons/logo_white.png',
                  height: 38,
                )),
            centerTitle: true,
            elevation: 10,
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: unSelected,
                ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (b) => const User_Setting()),
                  )
                },
              )
            ]),
      ),
      body: SafeArea(
        child: [const Home(), const Todo()]
            .elementAt(_bottomNavigationProvider.currentItem),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorStyles.appbarColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                  padding: itemPadding,
                  child: Image.asset('assets/icons/ic_calendar.png',
                      height: 20, width: 23, color: unSelected)),
              activeIcon: Container(
                  padding: itemPadding,
                  child: Image.asset(
                    'assets/icons/ic_calendar.png',
                    height: 20,
                    width: 23,
                    color: selected,
                  )),
              label: '캘린더',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: itemPadding,
                  child: Image.asset('assets/icons/ic_checklist.png',
                      height: 20, width: 20, color: unSelected)),
              activeIcon: Container(
                  padding: itemPadding,
                  child: Image.asset(
                    'assets/icons/ic_checklist.png',
                    height: 20,
                    width: 20,
                    color: selected,
                  )),
              label: 'TODO 리스트',
            ),
          ],
          currentIndex: _bottomNavigationProvider.currentItem,
          selectedItemColor: selected,
          unselectedItemColor: unSelected,
          onTap: (index) {
            _bottomNavigationProvider.setCurrentPage(index);
          }),
    );

/*    BottomNavigationBarItem _buildITem(BottomItem bottomItem){
      return navbarItems
    }*/
  }
}
