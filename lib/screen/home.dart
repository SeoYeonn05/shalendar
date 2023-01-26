import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shalendar/controller/user_controller.dart';
import 'package:shalendar/provider/Todo_provider.dart';
import 'package:shalendar/screen/calendarScreen.dart';
import 'package:shalendar/theme/color.dart';

import '../data/calendar.dart';
import '../dialog/dialog.dart';
import '../provider/bottom_nav_provider.dart';
import '../provider/home_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeProvider _homeProvider;
  late HomeState state;
  late UserController userController;

  var logger = Logger(printer: PrettyPrinter());

  @override
  initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).getCalendar();
    userController = Get.put(UserController());
  }

  @override
  Widget build(BuildContext context) {
    _homeProvider = Provider.of<HomeProvider>(context);
    state = _homeProvider.state;

    Widget routeListWidget() {
      if (state == HomeState.loading) {
        return messageWidget("로딩중");
      } else if (state == HomeState.empty) {
        return messageWidget("캘린더가 존재하지 않습니다");
      } else if (state == HomeState.calendarCompleted) {
        _homeProvider.getInform();
        return messageWidget("정보를 불러오는 중입니다");
      } else if (state == HomeState.infoCompleted) {
        _homeProvider.getAchievementRate();
        return messageWidget("정보를 불러오는 중입니다");
      } else {
        final calendarList = _homeProvider.calendarList;
        final themeMap = _homeProvider.themeMap;
        late Map<String, String> calUserName = _homeProvider.calUserName;
        late Map<String, int> calUserCount = _homeProvider.calUserCount;
        late Map<String, double> completeRate = _homeProvider.completeRate;
        if (calendarList != null) {
          return Expanded(
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: calendarList.length,
                  itemBuilder: (BuildContext context, index) => listCard(
                      calendarList[index],
                      themeMap,
                      calUserName,
                      calUserCount,
                      completeRate),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4 / 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10)));
        } else {
          return Container();
        }
      }
    }

    return Scaffold(
        floatingActionButton: floatingButtons(),
        body: Container(
            color: ColorStyles.backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 15),
                routeListWidget(),
              ],
            )));
  }

  Widget messageWidget(String message) => Container(
        height: 100,
        alignment: Alignment.center,
        child: Text(
          message,
          style: const TextStyle(fontSize: 30),
        ),
      );

  Widget listCard(
          Calendar calendar,
          Map<int, int> themeMap,
          Map<String, String> userName,
          Map<String, int> count,
          Map<String, double> completeRate) =>
      Container(
          child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                  onTap: () {
                    print('clicked ${calendar.calendarName}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (b) => MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                                create: (context) => TodoProvider()),
                          ],
                          child: EventCalendarScreen(calendar),
                        ),
                      ),
                    );
                  },
                  child: Stack(fit: StackFit.expand, children: <Widget>[
/*                Image.asset(
                  route.image!,
                  fit: BoxFit.fill,
                ),*/
                    /// 테마에 따른 색상
                    Container(
                        //alignment: Alignment.bottomRight,
                        padding: EdgeInsets.all(10),
                        color: Color(
                            themeMap[int.parse(calendar.calendarId ?? '0')] ??
                                4294311867),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${calendar.calendarName!}  ",
                                style: const TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Flexible(
                                    fit: FlexFit.loose,
                                    child: SizedBox(width: 200)),
                                Text(
                                    "${completeRate[calendar.calendarId]?.toInt()}%") /*${_homeProvider.completeTodoRate[calendar.calendarId]}*/
                              ],
                            ),
                            Row(
                              children: [
                                const Flexible(
                                    fit: FlexFit.loose,
                                    child: SizedBox(width: 50)),
                                Text(
                                    "${userName[calendar.calendarId]} 외 ${count[calendar.calendarId]}명")
                              ],
                            )
                          ],
                        )),
                  ]))));
  Color selectColor(Map<int, int> themeColor, int calendarId) {
    return Color(themeColor[calendarId] ?? 0);
  }

  Widget? floatingButtons() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      visible: true,
      curve: Curves.bounceIn,
      backgroundColor: ColorStyles.appbarColor,
      children: [
        SpeedDialChild(
            child: const Icon(Icons.settings_sharp, color: Colors.white),
            label: "생성",
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 13.0),
            backgroundColor: ColorStyles.appbarColor,
            labelBackgroundColor: ColorStyles.appbarColor,
            onTap: () {
              dialog(context, 1, _homeProvider);
            }),
        SpeedDialChild(
          child: const Icon(
            Icons.add_chart_rounded,
            color: Colors.white,
          ),
          label: "참가",
          backgroundColor: ColorStyles.appbarColor,
          labelBackgroundColor: ColorStyles.appbarColor,
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 13.0),
          onTap: () {
            dialog(context, 2, _homeProvider);
          },
        )
      ],
    );
  }
}
