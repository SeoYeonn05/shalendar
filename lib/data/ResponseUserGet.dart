import 'package:shalendar/data/user.dart';

class ResponseUserGet {
  final String result;
  final User user;

  ResponseUserGet({required this.result, required this.user});

  factory ResponseUserGet.fromJson(Map<String?, dynamic?> json) {
    return ResponseUserGet(
      result: json['result'],
      user: User.fromJson(json['user']),
    );
  }
}
