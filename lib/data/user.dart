/// 데이터베이스에서 http로 가져온 json 파일 매핑
class User {
  String? userId;
  String? email;
  String? name;
  String? password;

  User({this.userId, this.email, this.name, this.password});

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        userId: parsedJson[''],
        email: parsedJson[''],
        name: parsedJson[''],
        password: parsedJson['']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['email'] = email;
    data['name'] = name;
    data['password'] = password;

    return data;
  }
}
