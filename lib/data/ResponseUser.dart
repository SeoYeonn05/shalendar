class ResponseUser {
  final String result;
  final int? insertId;
  final String? token;

  ResponseUser(
      {required this.result, required this.insertId, required this.token});

  factory ResponseUser.fromJson(Map<String?, dynamic?> json) {
    return ResponseUser(
      result: json['result'],
      insertId: json['insertId'],
      token: json['token'],
    );
  }
}
