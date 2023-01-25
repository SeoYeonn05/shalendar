
import 'dart:convert';

class Calendar{
  String? calendarId;
  String? calendarName;
  DateTime? createdAt;
  int? userConnId;

  Calendar({
    this.calendarId,
    this.calendarName,
    this.createdAt,
    this.userConnId});

  factory Calendar.fromJson(Map<String, dynamic> parsedJson){
    return Calendar(
      calendarId: parsedJson['calendar_id'],
      calendarName: parsedJson['calendar_name'],
      createdAt: parsedJson['created_at'],
      userConnId: parsedJson['user_conn_id']
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data[''] = calendarId;
    data[''] = calendarName;

    return data;
  }
}