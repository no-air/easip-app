abstract class NetworkException implements Exception {
  final String message;
  
  NetworkException(this.message);
  
  @override
  String toString() => message;
}

class TimeoutException extends NetworkException {
  TimeoutException(super.message);
}

class HttpException extends NetworkException {
  final int? statusCode;
  final dynamic data;

  HttpException(super.message, {this.statusCode, this.data});
} 