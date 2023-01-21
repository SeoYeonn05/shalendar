
class Calendar{
  String? calendarId;
  String? calendarName;

  Calendar({
    this.calendarId,
    this.calendarName});

  factory Calendar.fromJson(Map<String, dynamic> parsedJson){
    return Calendar(
        calendarId: parsedJson[''],
        calendarName: parsedJson[''],
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data[''] = calendarId;
    data[''] = calendarName;

    return data;
  }
}