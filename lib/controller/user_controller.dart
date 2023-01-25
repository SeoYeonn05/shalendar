import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  String? token;

  /// 앱에 저장된 토큰을 가져오는 함수
  /// 토큰이 없으면 null을 리턴
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    return (token != null) ? token : null;
  }
}
