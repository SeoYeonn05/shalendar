import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import '../data/result.dart';

class NetworkHelper {
  static final NetworkHelper _instance = NetworkHelper._internal();
  factory NetworkHelper() => _instance;
  NetworkHelper._internal();

  var logger = Logger(
    printer: PrettyPrinter()
  );

/*  Future<Result> get(String action) async {
    var url = Uri.http('192.168.56.1:3000', action);
    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return Result(isSuccess: true, response: jsonDecode(response.body));
      } else {
        return Result(isSuccess: false, response: null);
      }
    } catch (e) {
      return Result(isSuccess: false, response: null);
    }
  }*/

  /// http 통신 중 post일 경우 사용
  /// url: 필요한 url 입력
  /// obj: post의 body에 넣을 object json 형태로 입력
  /// return 통신이 정상적으로 이루어진 경우 json, 아닐 경우 null
  Future post(String url, Object obj) async {
   var url = Uri.http('192.168.56.1:3000', 'api/user/register');
   var response = await http.post(url, body: obj);

   // 통신이 정상적으로 이루어진 경우 json, 아닐 경우 null
   // 후에 들어온 값이 fail인지는 따로 확인해야 함
   if(response.statusCode == 200){
     //로그로 들어온 값 확인하기
     logger.d(response.body);

     return response.body;
   } else{
     return null;
   }
  }
}
