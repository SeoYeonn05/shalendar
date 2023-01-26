import 'dart:ffi';

class Todo {
  int? todoId;
  String? title;
  DateTime? createdAt;
  DateTime? createdAt;
  String? calendarId;
  bool? isComplete;

  Todo(
      {this.todoId,
      this.title,
      this.createdAt,
      this.calendarId,
      this.isComplete});
  Todo(
      {this.todoId,
      this.title,
      this.createdAt,
      this.calendarId,
      this.isComplete});

  factory Todo.fromJson(Map<String, dynamic> tmp) {
    return Todo(
        todoId: tmp['todo_id'],
        calendarId: tmp['calendar_id'].toString(),
        isComplete: tmp['isComplete'],
        createdAt: DateTime.parse(tmp['created_at']),
        title: tmp['user_conn_id']);
  }

  Map<String, dynamic> toJson() {
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[''] = todoId;
    data[''] = title;
    data[''] = createdAt;
    data[''] = calendarId;
    data[''] = isComplete;

    return data;
  }

  Todo.parse(Map m) {
    todoId = m['todo_id'];
    title = m['title'];
    createdAt = DateTime.parse(m['created_at']);
    isComplete = (m['isComplete'] == 0) ? false : true;
    calendarId = m['calendar_id'].toString();
  }
}

