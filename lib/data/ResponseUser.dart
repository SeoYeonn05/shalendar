class ResponseUser {
  final String result;
  final int? insertId;

  ResponseUser({required this.result, required this.insertId});

  factory ResponseUser.fromJson(Map<String?, dynamic?> json) {
    return ResponseUser(
      result: json['result'],
      insertId: json['insertId'],
    );
  }
}
