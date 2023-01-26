import 'dart:ffi';

class Todo {
  int? todoId;
  String? title;
  DateTime? createdAt;
  String? calendarId;
  bool? isComplete;

  Todo(
      {this.todoId,
      this.title,
      this.createdAt,
      this.calendarId,
      this.isComplete});

  factory Todo.fromJson(Map<String, dynamic> parsedJson) {
    return Todo(
      todoId: parsedJson[''],
      title: parsedJson[''],
      createdAt: parsedJson[''],
      calendarId: parsedJson[''],
      isComplete: parsedJson[''],
    );
  }

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
