import 'dart:ffi';

class Todo {
  String? todoId;
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
}
