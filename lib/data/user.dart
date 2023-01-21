/// 데이터베이스에서 http로 가져온 json 파일 매핑
class User{
  String? userId;
  String? email;
  String? userName;
  String? password;

  User({
    this.userId,
    this.email,
    this.userName,
    this.password});

  factory User.fromJson(Map<String, dynamic> parsedJson){
    return User(
      userId: parsedJson[''],
      email: parsedJson[''],
      userName: parsedJson[''],
      password: parsedJson['']
    );
  }
 }