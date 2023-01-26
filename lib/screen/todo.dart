import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:shalendar/dialog/dialog.dart';
import 'package:shalendar/provider/Todo_provider.dart';
import 'package:shalendar/data/todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late TodoProvider _todoProvider;

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

    final todoList = _todoProvider.todoList;
    final themeMap = _todoProvider.themeMap;
    print(todoList);
    return Scaffold(
        body: Container(
            child: Column(
      children: [
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: todoList?.length,
              itemBuilder: (BuildContext context, index) =>
                  todoCard(todoList![index], themeMap)),
        )
      ],
    )
            // children: <Widget>[
            //   // Expanded(

            //   // ),
            // ],
            ));
  }

  Widget? floatingButtons() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      visible: true,
      curve: Curves.bounceIn,
      backgroundColor: const Color.fromARGB(0xFF, 0xFB, 0x95, 0x32),
      children: [
        SpeedDialChild(
            child: const Icon(Icons.settings_sharp, color: Colors.white),
            label: "생성",
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 13.0),
            backgroundColor: const Color.fromARGB(0xFF, 0xFB, 0x95, 0x32),
            labelBackgroundColor: const Color.fromARGB(0xFF, 0xFB, 0x95, 0x32),
            onTap: () {
              // dialog(context, 1);
            }),
      ],
    );
  }

  Widget todoCard(Todo todo, Map<int, int> themeMap) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 5),
          Column(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
              ),
              height: 60,
              child: Row(
                children: [],
              ),
            ),
          ])
          //   ],
          // ),
          // SizedBox(
          //   width: 10,
          // ),
          //
        ],
      ),
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
