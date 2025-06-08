import 'package:easip_app/app/core/config/env_config.dart';
import 'package:easip_app/app/core/network/api_request.dart';
import 'package:easip_app/app/modules/account/token_storage.dart';
import 'package:flutter/material.dart';

class AuthRequest<T> extends ApiRequest<T> {
  final String _path;
  final HttpMethod _method;
  final Map<String, dynamic>? _body;
  final T Function(dynamic) _fromJson;
  final bool _requiresAuth;

  AuthRequest({
    required String path,
    required HttpMethod method,
    Map<String, dynamic>? body,
    required T Function(dynamic) fromJson,
    bool requiresAuth = false,
    Map<String, dynamic>? headers,
  }) : _path = path,
       _method = method,
       _body = body,
       _fromJson = fromJson,
       _requiresAuth = requiresAuth;

  @override
  T parseResponse(dynamic data) {
    if (data == null) {
      throw Exception('Response data is null');
    }
    return _fromJson(data as Map<String, dynamic>);
  }

  @override
  String get baseUrl {
    final url = EnvConfig().baseUrl;
    debugPrint('Base URL: $url');
    return url;
  }

  @override
  String get url {
    final url =
        '${baseUrl.endsWith('/') ? baseUrl : '$baseUrl/'}${_path.startsWith('/') ? _path.substring(1) : _path}';
    debugPrint('Full URL: $url');
    return url;
  }

  @override
  String get path => _path;

  @override
  String get method => _method.value;

  @override
  Future<Map<String, dynamic>> get headers async {
    final token = await TokenStorage.accessToken;
    final headers = <String, dynamic>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token?.isNotEmpty == true) {
      headers['X-AUTH-TOKEN'] = token!;
    }

    return headers;
  }

  @override
  Map<String, dynamic>? get body => _body;

  @override
  Map<String, dynamic>? get queryParameters => null;
}
