
import 'dart:ffi';

class Todo{
  String? todoId;
  String? title;
  DateTime? createdAt;
  String? calendarId;
  bool? isComplete;

  Todo({
    this.todoId,
    this.title,
    this.createdAt,
    this.calendarId,
    this.isComplete
  });

  factory Todo.fromJson(Map<String, dynamic> tmp){
    return Todo(
        todoId: tmp['todo_id'].toString(),
        calendarId: tmp['calendar_id'].toString(),
        isComplete: tmp['isComplete'],
        createdAt: DateTime.parse(tmp['created_at']),
        title: tmp['user_conn_id']
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data[''] = todoId;
    data[''] = title;
    data[''] = createdAt;
    data[''] = calendarId;
    data[''] = isComplete;

    return data;
  }
}