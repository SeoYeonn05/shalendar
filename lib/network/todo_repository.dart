import 'dart:io';

import 'package:get/get.dart';
import 'package:shalendar/controller/user_controller.dart';

class TodoRepository extends GetConnect {
  final userController = Get.put(UserController());

  @override
  void onInit() {
    allowAutoSignedCert = true;
    httpClient.baseUrl = 'http://43.200.165.21';
    httpClient.addRequestModifier<void>((request) {
      request.headers['Accept'] = 'application/json';
      return request;
    });
    super.onInit();
  }

  Future<Map?> todoIndex(String calendarId) async {
    String? token = await userController.getToken();
    if (token == null) return null;
    Response response = await get(
      "/calendar/${calendarId}/todo",
      headers: {'token': token!},
    );
    return (response.statusCode == 200) ? response.body : null;
  }
}