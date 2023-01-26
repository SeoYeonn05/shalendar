import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shalendar/controller/todo_controller.dart';
import 'package:shalendar/data/todo.dart';
import 'package:shalendar/screen/calendar_todo.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../data/calendar.dart';
import '../utils/calendar_event.dart';
import 'home.dart';

class EventCalendarScreen extends StatefulWidget {
  Calendar calendar;
  EventCalendarScreen(this.calendar, {Key? key}) : super(key: key);

  @override
  State<EventCalendarScreen> createState() => _EventCalendarScreenState();
}

class _EventCalendarScreenState extends State<EventCalendarScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<String, List> mySelectedEvents = {};

  final titleController = TextEditingController();
  final descpController = TextEditingController();
  final todoController = Get.put(TodoController());

  @override
  void initState() {
    _fetchData();
    // TODO: implement initState
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents =
        ValueNotifier(_getEventsForDay(_selectedDay!, todoController.todoList));
  }

  void _fetchData() async {
    bool result = await todoController.todoIndex(widget.calendar.calendarId!);
  }

  /// 뒤로가기 버튼 눌렀을 때
  void backButton() {
    Navigator.pop(context);
  }

  void goCalendarTodo() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (b) =>
              todolist(_focusedDay, int.parse(widget.calendar.calendarId!))),
    );
  }

  /// 받아온 todo 목록을 캘린더에 표시
  List<Event> _getEventsForDay(DateTime day, List<dynamic> todoList) {
    var todoSource = Map<DateTime, List<Event>>();
    todoList.forEach((element) {
      var e = element as Todo;
      if (todoSource[e.createdAt!] == null) {
        todoSource[e.createdAt!] = [Event(e.title!)];
      } else {
        todoSource[e.createdAt!]?.add(Event(e.title!));
      }
    });

    var todos = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(todoSource);

    // Implementation example
    return todos[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value =
          _getEventsForDay(selectedDay, todoController.todoList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xff3E3E3E),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('${widget.calendar.calendarName}'),
        centerTitle: true,
        backgroundColor: Color(0xff676767),
        leading: IconButton(
            onPressed: backButton,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: GetBuilder<TodoController>(builder: (c) {
        return Column(
          children: [
            TableCalendar<Event>(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: _calendarFormat,
              eventLoader: (day) => _getEventsForDay(day, c.todoList),
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                // Use `CalendarStyle` to customize the UI
                outsideDaysVisible: false,
              ),
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          onTap: () => print('${value[index]}'),
                          title: Text('${value[index]}'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff676767),
        onPressed: goCalendarTodo,
        child: const Icon(
          Icons.keyboard_arrow_right,
          size: 40,
        ),
      ),
    );
  }
}
