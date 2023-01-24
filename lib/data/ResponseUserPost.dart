class ResponseUserPost {
  final String result;
  final int? insertId;
  final String? token;

  ResponseUserPost(
      {required this.result, required this.insertId, required this.token});

  factory ResponseUserPost.fromJson(Map<String?, dynamic?> json) {
    return ResponseUserPost(
      result: json['result'],
      insertId: json['insertId'],
      token: json['token'],
    );
  }
}
