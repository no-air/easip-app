abstract class NetworkException implements Exception {
  final String message;
  
  NetworkException(this.message);
  
  @override
  String toString() => message;
}

class TimeoutException extends NetworkException {
  TimeoutException(String message) : super(message);
}

class HttpException extends NetworkException {
  final int? statusCode;
  final dynamic data;

  HttpException(String message, {this.statusCode, this.data}) : super(message);
} 