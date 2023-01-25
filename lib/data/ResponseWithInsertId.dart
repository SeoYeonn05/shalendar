class ResponseWithResultId {
  final String result;
  final int? insertId;

  ResponseWithResultId({required this.result, required this.insertId});

  factory ResponseWithResultId.fromJson(Map<String?, dynamic?> json) {
    return ResponseWithResultId(
      result: json['result'],
      insertId: json['insertId'],
    );
  }
}
