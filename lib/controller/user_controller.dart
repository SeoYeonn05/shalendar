import 'package:get/get.dart';
import 'package:shalendar/theme/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  String? token;

  /// 앱에 저장된 토큰을 가져오는 함수
  /// 토큰이 없으면 null을 리턴
  Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      return (token != null) ? token : null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// 테마를 로컬에 저장하는 함수
  void setTheme(int calendarId, int? color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        '$calendarId', (color == null) ? ColorStyles.themeYellow.value : color);
  }

  /// 앱에 저장된 캘린더 테마를 가져오는 함수
  Future<int> getTheme(int calendarId) async {
    final prefs = await SharedPreferences.getInstance();
    final int? theme = prefs.getInt('$calendarId');
    return (theme != null) ? theme : ColorStyles.themeYellow.value;
  }

  /// 앱에 저장된 캘린더 테마를 삭제하는 함수
  void deleteTheme(int calendarId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$calendarId');
  }
}
