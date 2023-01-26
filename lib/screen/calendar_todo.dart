import 'package:flutter/material.dart';

import '../data/Calendar.dart';

class todolist extends StatefulWidget {
  int calendarId;
  DateTime date;
  todolist(this.date, this.calendarId, {super.key});
  @override
  State<todolist> createState() => _todolistState();
}

class _todolistState extends State<todolist> {
  List todos = [];
  String input = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.date}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("Add Todolist"),
                    content: TextField(
                      onChanged: (String value) {
                        input = value;
                      },
                    ),
                    actions: <Widget>[
                      FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              todos.add(input);
                            });
                            Navigator.of(context).pop(); // input 입력 후 창 닫히도록
                          },
                          child: Text("Add"))
                    ]);
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                // 삭제 버튼 및 기능 추가
                key: Key(todos[index]),
                child: Card(
                    elevation: 4,
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      title: Text(todos[index]),
                      trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              showAlertDialog(index); // 경고창이 오류가 뜸
                              //todos.removeAt(index);
                            });
                          }),
                    )));
          }),
    );
  }

  void showAlertDialog(index) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('삭제 경고'),
          content: Text("정말 삭제하시겠습니까?"),
          actions: <Widget>[
            FloatingActionButton(
              child: Text('삭제'),
              onPressed: () {
                Navigator.pop(context, "삭제");
                todos.removeAt(index);
                //Navigator.pop(context);
              },
            ),
            FloatingActionButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.pop(context, "취소");
              },
            ),
          ],
        );
      },
    );
  }
}
