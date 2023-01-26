import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shalendar/data/calendar.dart';
import 'package:shalendar/data/todo.dart';
import 'package:shalendar/provider/Todo_provider.dart';
import 'package:shalendar/theme/color.dart';
import 'package:shalendar/utils/snackbar.dart';
import 'package:shalendar/widget/addTodoDialog.dart';
import 'package:shalendar/widget/deleteTodoDialog.dart';

import '../controller/todo_controller.dart';

class todolist extends StatefulWidget {
  Calendar calendar;
  DateTime date;
  todolist(this.date, this.calendar, {super.key});

  @override
  State<todolist> createState() => _todolistState();
}

class _todolistState extends State<todolist> {
  String input = "";
  late TodoProvider _todoProvider;
  final todoController = Get.put(TodoController());

  @override
  void initState() {
    super.initState();
    Provider.of<TodoProvider>(context, listen: false).getTodoListByCalendar(
        int.parse(widget.calendar.calendarId!), widget.date);
    todoController.todoDayIndex(widget.calendar.calendarId!, widget.date);
  }

  @override
  Widget build(BuildContext context) {
    _todoProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
              "${widget.date.year}년 ${widget.date.month}월 ${widget.date.day}일의 일정"),
          backgroundColor: ColorStyles.appbarColor,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff848484),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddTodoDialog(widget.calendar.calendarId, widget.date);
                });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: GetBuilder<TodoController>(builder: (c) {
          return Container(
            color: Color(0xff3E3E3E),
            child: ListView.builder(
              itemCount: c.todoDayList.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                    // 삭제 버튼 및 기능 추가
                    key: Key(c.todoDayList[index].todoId.toString()),
                    child: Card(
                        elevation: 4,
                        margin: EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: todoCard(_todoProvider.themeMap, widget.calendar,
                            c.todoDayList, index)
                        // ListTile(
                        //   title: Text('hi'),
                        //   trailing:
                        //       ),
                        // )
                        ));
              },
            ),
          );
        }));
  }

  Widget todoCard(Map<int, int> themeMap, Calendar calendar,
      List<dynamic> todoDayList, int index) {
    Todo todo = todoDayList[index];
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
                  color: Color(
                      themeMap[int.parse(calendar.calendarId ?? '0')] ??
                          4294311867),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(2, 2)),
                  ]),
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
                          child: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  showAlertDialog(index); // 경고창이 오류가 뜸
                                });
                              }
                              // Checkbox(
                              //   value: todo.isComplete,
                              //   onChanged: ((value) {
                              //     todo.isComplete = value;
                              //     final result =
                              //         _todoProvider.changeTodoCompleteState(
                              //             todo.todoId?.toInt() ?? 0);
                              //     if (result == false) {
                              //       showSnackBar(context, '변경에 실패했습니다.');
                              //     }
                              //   }),
                              // ),

                              ),
                        ),
                      ),
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

  void showAlertDialog(index) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button
      builder: (BuildContext context) {
        // return AlertDialog(
        //   title: Text('삭제 경고'),
        //   content: Text("정말 삭제하시겠습니까?"),
        //   actions: <Widget>[
        //     FloatingActionButton(
        //       child: Text('삭제'),
        //       onPressed: () {
        // Navigator.pop(context, "삭제");
        //         todos.removeAt(index);
        //         //Navigator.pop(context);
        //       },
        //     ),
        //     FloatingActionButton(
        //       child: Text('취소'),
        //       onPressed: () {
        //         Navigator.pop(context, "취소");
        //       },
        //     ),
        //   ],
        // );
        return DeleteTodoDialog(
            todoController.todoDayList[index].todoId,
            todoController.todoDayList,
            index,
            widget.calendar.calendarId,
            widget.date);
      },
    );
  }
}
