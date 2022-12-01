class HttpException implements Exception {
  HttpException({
    required this.msg,
    required this.statusCode,
  });

  final String msg;
  final int statusCode;

  @override
  String toString() {
    return msg;
  }
}
