import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:shalendar/data/calendar.dart';
import 'package:shalendar/dialog/dialog.dart';
import 'package:shalendar/provider/Todo_provider.dart';
import 'package:shalendar/data/todo.dart';
import 'package:shalendar/provider/home_provider.dart';
import 'package:shalendar/theme/color.dart';
import 'package:shalendar/utils/snackbar.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late TodoProvider _todoProvider;
  late HomeProvider _homeProvider;
  @override
  void initState() {
    super.initState();
    final tmp = Provider.of<TodoProvider>(context, listen: false);
    tmp.getTodoListByUser();
    print(tmp);
    print(context);
  }

  @override
  Widget build(BuildContext context) {
    print(context);
    _todoProvider = Provider.of<TodoProvider>(context);
    _homeProvider = Provider.of<HomeProvider>(context);
    final todoList = _todoProvider.todoList;
    final themeMap = _todoProvider.themeMap;
    final calendarList = _homeProvider.calendarList;
    return Scaffold(
        body: Container(
            color: ColorStyles.themeBlack,
            padding: EdgeInsets.only(top: 10),
            child: ListView.builder(
              itemBuilder: ((context, index) => todoCard(
                  todoList![index],
                  themeMap,
                  calendarList!.firstWhere((element) =>
                      element.calendarId == todoList![index].calendarId))),
              itemCount: todoList?.length,
            )));
    // children: <Widget>[
    //   // Expanded(

    //   // ),
    // ],
  }

  Widget todoCard(Todo todo, Map<int, int> themeMap, Calendar calendar) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Color(themeMap[int.parse(calendar.calendarId ?? '0')] ??
                    4294311867),
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.black),
              ),
            ),
            SizedBox(width: 5),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  // border: Border.all(width: 1, color: Colors.black),
                  ),
              height: 80,
              child: Column(
                children: [
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(width: 1, color: Colors.black),
                    // ),
                    height: 20,
                    child: Text('${calendar.calendarName}'),
                    alignment: Alignment.topLeft,
                  ),
                  Expanded(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          // decoration: BoxDecoration(
                          //   border: Border.all(width: 1, color: Colors.black),
                          // ),
                          child: Text(
                              '${todo.createdAt?.month}/${todo.createdAt?.day}',
                              style: TextStyle(fontSize: 30)),
                          alignment: Alignment.center,
                        ),
                      ),
                      Expanded(
                          flex: 7,
                          child: Container(
                            // decoration: BoxDecoration(
                            //   border: Border.all(width: 1, color: Colors.black),
                            // ),
                            child: Text('${todo.title}',
                                style: TextStyle(fontSize: 24)),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                              // decoration: BoxDecoration(
                              //   border: Border.all(width: 1, color: Colors.black),
                              // ),
                              child: Checkbox(
                            value: todo.isComplete,
                            onChanged: ((value) {
                              todo.isComplete = value;
                              final result =
                                  _todoProvider.changeTodoCompleteState(
                                      int.parse(todo.todoId ?? '0'));
                              if (result == false) {
                                showSnackBar(context, '변경에 실패했습니다.');
                              }
                            }),
                          ))),
                    ],
                  )),
                ],
              ),
            ))
          ],
        ),
      ),
      onTap: () {
        // tap시
      },
    );
  }
}

//  SizedBox(
//                     width: 30,
//                     height: 30,
//                     child: InkWell(
//                         radius: 100,
//                         onTap: () {},
//                         child: (todo.isComplete!)
//                             ? Image.asset('assets/icons/ic_checked.png')
//                             : Image.asset('assets/icons/ic_crossed.png')),
//                   )
