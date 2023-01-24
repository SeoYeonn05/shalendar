import 'dart:ffi';

/// 데이터베이스에서 http로 가져온 json 파일 매핑
class User {
  String? email;
  String? name;
  String? password;

  User({this.email, this.name, this.password});

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        email: parsedJson['email'],
        name: parsedJson['user_name'],
        password: parsedJson['password']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['password'] = password;

    return data;
  }
}
