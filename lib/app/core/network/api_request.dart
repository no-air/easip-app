abstract class ApiRequest<T> {
  String get baseUrl;
  String get path;
  String get method;
  dynamic get headers;
  Map<String, dynamic>? get queryParameters;
  dynamic get body;

  String get url => '$baseUrl$path';

  T? parseResponse(dynamic data) {
    if (data == null) return null;

    final type = T;
    if (type == List) {
      if (data is! List) {
        throw FormatException('Expected List but got ${data.runtimeType}');
      }
      return data as T;
    }
    return data as T;
  }
}

enum HttpMethod {
  get,
  post,
  put,
  delete;

  String get value => name.toUpperCase();
}
