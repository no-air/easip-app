abstract class ApiRequest {
  String get baseUrl;
  String get path;
  String get method;
  Map<String, String>? get headers;
  Map<String, dynamic>? get queryParameters;
  dynamic get body;

  String get url => '$baseUrl$path';

  T parseResponse<T>(dynamic data);
}

enum HttpMethod {
  get,
  post,
  put,
  delete;

  String get value => name.toUpperCase();
}