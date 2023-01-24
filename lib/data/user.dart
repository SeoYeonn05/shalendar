/// 데이터베이스에서 http로 가져온 json 파일 매핑
class User {
  String? userId;
  String? email;
  String? name;
  String? password;

  User({this.userId, this.email, this.name, this.password});

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        userId: parsedJson['user_id'],
        email: parsedJson['email'],
        name: parsedJson['user_name'],
        password: parsedJson['password']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_Id'] = userId;
    data['email'] = email;
    data['user_name'] = name;
    data['password'] = password;

    return data;
  }
}
