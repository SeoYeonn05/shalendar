import 'package:flutter/material.dart';
import 'package:shalendar/data/ResponseWithInsertId.dart';
import 'package:shalendar/network/network_helper.dart';
import 'package:sharedpreference/sharedpreference.dart';
import 'package:table_calendar/table_calendar.dart';

class todoDialog extends StatelessWidget {
  var calendarId;
  todoDialog(this.calendarId, {super.key});

  final changeTodoController = TextEditingController();
  final NetworkHelper networkHelper = NetworkHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          OutlinedButton(
              child: Text('test'),
              onPressed: (() {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('일정 수정'),
                        content: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Title',
                              ),
                              controller: changeTodoController,
                            )
                          ],
                        ),
                        actions: [
                          // ok button
                          OutlinedButton(
                              onPressed: () async {
                                // make body
                                Map<String, dynamic> body = <String, dynamic>{};
                                body['title'] = changeTodoController.text;
                                // request url
                                var url = "calendar/$calendarId/todo";
                                // request headers
                                Map<String, String> headers =
                                    SharedPreference.getInstance();
                                <String, String>{};
                                // send request
                                var result = await networkHelper
                                    .postWithHeaders(url, headers, body);
                                
                                // if response is not null
                                if (result != null) {
                                  // get changed todo id
                                  var insertId =
                                      ResponseWithResultId.fromJson(result)
                                          .insertId;
                                  
                                }else{
                                    showDialog(context: 
                                    context
                                    , builder: (BuildContext context){
                                      return AlertDialog
                                    })
                                }
                              },
                              child: Text('ok')),
                          // cancel
                          OutlinedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('cancel')),
                        ],
                      );
                    });
              })),
        ],
      ),
    );
  }
}
