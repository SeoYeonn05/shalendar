import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shalendar/controller/todo_controller.dart';
import 'package:shalendar/data/todo.dart';
import 'package:shalendar/provider/Todo_provider.dart';
import 'package:shalendar/screen/calendar_todo.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../controller/user_controller.dart';
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
  final userController = Get.put(UserController());

  late int theme;

  @override
  void initState() {
    _fetchData();
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents =
        ValueNotifier(_getEventsForDay(_selectedDay!, todoController.todoList));
  }

  void _fetchData() async {
    bool result = await todoController.todoIndex(widget.calendar.calendarId!);
    await todoController.loadTheme(widget.calendar.calendarId!);
  }

  /// 뒤로가기 버튼 눌렀을 때
  void backButton() {
    Navigator.pop(context);
  }

  /// 캘린더 세팅
  void calendarSetting() {
    print("캘린더 세팅 클릭");
  }

  /// 캘린더 해당 날짜로 들어갈 때
  void goCalendarTodo() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (b) => MultiProvider(providers: [
                  ChangeNotifierProvider(create: (context) => TodoProvider()),
                ], child: todolist(_focusedDay, widget.calendar))));
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
          ),
        ),
        actions: [
          IconButton(
            onPressed: calendarSetting,
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: GetBuilder<TodoController>(builder: (c) {
        return Container(
          color: Color(0xff3E3E3E),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(8),
                child: TableCalendar<Event>(
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  calendarFormat: _calendarFormat,
                  eventLoader: (day) => _getEventsForDay(day, c.todoList),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: CalendarStyle(
                    rowDecoration: BoxDecoration(color: Color(0xff555555)),
                    weekendTextStyle:
                        TextStyle(color: Color.fromARGB(255, 255, 129, 120)),
                    isTodayHighlighted: true,
                    outsideDaysVisible: true,
                    defaultTextStyle: TextStyle(color: Colors.white),
                    markerDecoration: BoxDecoration(color: Color(c.theme)),
                    tableBorder: TableBorder(
                      top: BorderSide(color: Color(0xffD9D9D9)),
                      horizontalInside: BorderSide(color: Color(0xffD9D9D9)),
                      verticalInside: BorderSide(color: Color(0xffD9D9D9)),
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    decoration: BoxDecoration(color: Color(0xff555555)),
                    formatButtonVisible: false,
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 18),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    decoration: BoxDecoration(color: Color(0xff555555)),
                    weekdayStyle: TextStyle(color: Colors.white),
                    weekendStyle:
                        TextStyle(color: Color.fromARGB(255, 255, 129, 120)),
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
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(8),
                  color: Color(0xff555555),
                  child: ValueListenableBuilder<List<Event>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Color(0xff555555),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ListTile(
                              onTap: () => print('${value[index]}'),
                              title: Text(
                                '${value[index]}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff848484),
        onPressed: goCalendarTodo,
        child: const Icon(
          Icons.keyboard_arrow_right,
          size: 40,
        ),
      ),
    );
  }
}
