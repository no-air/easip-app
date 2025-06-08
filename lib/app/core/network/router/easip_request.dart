import 'package:easip_app/app/core/config/env_config.dart';
import 'package:easip_app/app/core/network/api_request.dart';

class EasipRequest<T> extends ApiRequest<T> {
  final String _path;
  final HttpMethod _method;
  final Map<String, dynamic>? _body;
  final Map<String, String>? _headers;
  final Map<String, dynamic>? _queryParameters;
  final T Function(Map<String, dynamic>) fromJson;

  EasipRequest({
    required String path,
    required HttpMethod method,
    required this.fromJson,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) : _path = path,
       _method = method,
       _body = body,
       _headers = headers,
       _queryParameters = queryParameters;

  @override
  String get baseUrl => EnvConfig().baseUrl;

  @override
  String get path => _path;

  @override
  String get method => _method.value;

  @override
  Map<String, String>? get headers => _headers;

  @override
  Map<String, dynamic>? get queryParameters => _queryParameters;

  @override
  Map<String, dynamic>? get body => _body;

  @override
  T parseResponse(dynamic data) {
    if (data == null) throw Exception('Response data is null');
    if (data is! Map<String, dynamic>)
      throw Exception('Invalid response format');
    return fromJson(data);
  }
}
