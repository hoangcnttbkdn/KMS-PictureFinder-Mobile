class HttpException implements Exception {
  HttpException(
    this.statusCode, {
    this.message = '',
  });

  final String? message;
  final int statusCode;

  @override
  String toString() =>
      '$runtimeType(message: $message, statusCode: $statusCode)';
}

class BadRequestException extends HttpException {
  BadRequestException({super.message = 'Bad Request'}) : super(400);
}

class PayloadTooLargeException extends HttpException {
  PayloadTooLargeException({super.message = 'File too large'}) : super(413);
}

class ServerErrorException extends HttpException {
  ServerErrorException({super.message = 'Internal Server Error'}) : super(500);
}
