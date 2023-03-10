import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import '../controller/user_controller.dart';
import '../data/Calendar.dart';
import '../data/ResponseUserGet.dart';
import '../data/ResponseUserPost.dart';
import '../data/result.dart';
import '../data/user.dart';

class NetworkHelper {
  final baseUrl = '43.200.165.21';

  static final NetworkHelper _instance = NetworkHelper._internal();
  factory NetworkHelper() => _instance;
  NetworkHelper._internal();
  final userController = Get.put(UserController());

  var logger = Logger(printer: PrettyPrinter());

  Future getWithHeaders(String requestUrl, Map<String, String> header) async {
    var url = Uri.http(baseUrl, requestUrl);
    var response = await http.get(url, headers: header);
    logger.d(response);

    // 통신이 정상적으로 이루어진 경우 json, 아닐 경우 null
    // 후에 들어온 값이 fail인지는 따로 확인해야 함
    // 400인 경우 오류메시지 출력을 위해 json 넘김
    if (response.statusCode == 200) {
      //로그로 들어온 값 확인하기
      logger.d(response);

      return jsonDecode(response.body);
    } else {
      print("response.statusCode: ${response.statusCode}");
      return null;
    }
  }

  Future getUser(String requestUrl) async {
    String? token = await userController.getToken();
    if (token == null) return null;
    var url = Uri.http(baseUrl, requestUrl);
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'token': token
    };
    http.Response response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      logger.d(response.body);
      return ResponseUserGet.fromJson(jsonDecode(response.body)).user;
    } else {
      return null;
    }
  }

  Future deleteUser(String requestUrl) async {
    String? token = await userController.getToken();
    if (token == null) return null;
    var url = Uri.http(baseUrl, requestUrl);
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'token': token
    };
    http.Response response = await http.delete(url, headers: header);

    if (response.statusCode == 200) {
      logger.d(response.body);
      return ResponseUserPost.fromJson(jsonDecode(response.body)).result;
    } else {
      return null;
    }
  }

  /// http 통신 중 post일 경우 사용
  /// requestUrl: 필요한 url 입력
  /// obj: post의 body에 넣을 object json 형태로 입력
  /// return 통신이 정상적으로 이루어진 경우 json, 아닐 경우 null
  Future post(String requestUrl, Object obj) async {
    var url = Uri.http(baseUrl, requestUrl);
    var response = await http.post(url, body: obj);

    // 통신이 정상적으로 이루어진 경우 json, 아닐 경우 null
    // 후에 들어온 값이 fail인지는 따로 확인해야 함
    // 400인 경우 오류메시지 출력을 위해 json 넘김
    if (response.statusCode == 200 || response.statusCode == 400) {
      //로그로 들어온 값 확인하기
      logger.d(response.body);

      return jsonDecode(response.body);
    } else {
      print("response.statusCode: ${response.statusCode}");
      return null;
    }
  }

  Future postWithHeaders(
      String requestUrl, Map<String, String> header, Object obj) async {
    var url = Uri.http(baseUrl, requestUrl);
    var response = await http.post(url, headers: header, body: obj);

    // 통신이 정상적으로 이루어진 경우 json, 아닐 경우 null
    // 후에 들어온 값이 fail인지는 따로 확인해야 함
    // 400인 경우 오류메시지 출력을 위해 json 넘김
    if (response.statusCode == 200 || response.statusCode == 400) {
      //로그로 들어온 값 확인하기
      logger.d(response.body);

      return jsonDecode(response.body);
    } else {
      print("response.statusCode: ${response.statusCode}");
      return null;
    }
  }

  Future deleteWithOnlyHeaders(
      String requestUrl, Map<String, String> header) async {
    var url = Uri.http(baseUrl, requestUrl);
    var response = await http.delete(url, headers: header);

    // 통신이 정상적으로 이루어진 경우 json, 아닐 경우 null
    // 후에 들어온 값이 fail인지는 따로 확인해야 함
    // 400인 경우 오류메시지 출력을 위해 json 넘김
    if (response.statusCode == 200 || response.statusCode == 400) {
      //로그로 들어온 값 확인하기
      logger.d(response.body);

      return jsonDecode(response.body);
    } else {
      print("response.statusCode: ${response.statusCode}");
      return null;
    }
  }

  Future addCalendar(String requestUrl, String name) async {
    String? token = await userController.getToken();
    if (token == null) return null;
    var url = Uri.http(baseUrl, requestUrl);
    Map<String, String> header = {'Accept': 'application/json', 'token': token};
    http.Response response =
        await http.post(url, headers: header, body: {'name': name});
    logger.d(response.body);

    if (response.statusCode == 200) {
      return ResponseUserPost.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future joinCalendar(String code) async {
    String? token = await userController.getToken();
    if (token == null) return null;

    String requestUrl = "api/calendar/process-key";

    final queryParameters = {
      'shareKey': code,
    };

    var url = Uri.http(baseUrl, requestUrl, queryParameters);
    Map<String, String> header = {'Accept': 'application/json', 'token': token};
    http.Response response = await http.post(url, headers: header);
    logger.d(response.body);

    if (response.statusCode == 200) {
      return ResponseUserPost.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 500) {
      return ResponseUserPost.fromJson({'result': '캘린더 참가 코드가 잘못 되었습니다.'});
    } else if (response.statusCode == 400) {
      return ResponseUserPost.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
