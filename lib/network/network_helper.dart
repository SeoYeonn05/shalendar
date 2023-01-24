import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import '../data/result.dart';

class NetworkHelper {
  final baseUrl = '43.200.165.21';

  static final NetworkHelper _instance = NetworkHelper._internal();
  factory NetworkHelper() => _instance;
  NetworkHelper._internal();

  var logger = Logger(printer: PrettyPrinter());

  Map<String, String> createHeader(String? token) {
    final Map<String, String> header = <String, String>{};
    header['Content-Type'] = 'application/json';
    header['Accept'] = 'application/json';
    header['token'] = (token != null) ? token : "";
    return header;
  }

  Future<http.Response> get(String requestUrl, {String? token = null}) async {
    var url = Uri.http(baseUrl, requestUrl);
    var response = await http.get(url, headers: createHeader(token));
    logger.d(response.body);

    return response;
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
}
