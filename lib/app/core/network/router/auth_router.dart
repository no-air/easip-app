import 'package:flutter/foundation.dart';
import 'package:easip_app/app/core/network/api_request.dart';
import 'package:easip_app/app/core/config/env_config.dart';

class AuthRouter {
  static ApiRequest<AuthResponse> signIn({
    required AuthProvider provider,
    required String socialToken,
  }) {
    return AuthRequest<AuthResponse>(
      path: '/v1/auth/social/${provider.value}',
      method: HttpMethod.post,
      body: {"socialToken": socialToken},
    );
  }

  static refresh({required String refreshToken}) {
    return AuthRequest<AuthResponse>(
      path: '/v1/auth/refresh',
      method: HttpMethod.post,
      body: {"refreshToken": refreshToken},
    );
  }
}

enum AuthProvider {
  google('GOOGLE'),
  apple('APPLE');

  final String value;
  const AuthProvider(this.value);
}

class AuthRequest<T> extends ApiRequest<T> {
  final String _path;
  final HttpMethod _method;
  final Map<String, dynamic>? _body;

  AuthRequest({
    required String path,
    required HttpMethod method,
    Map<String, dynamic>? body,
  }) : _path = path,
       _method = method,
       _body = body;

  @override
  String get baseUrl => EnvConfig().baseUrl;

  @override
  String get path => _path;

  @override
  String get method => _method.value;

  @override
  Map<String, String>? get headers => null;

  @override
  Map<String, dynamic>? get queryParameters => null;

  @override
  Map<String, dynamic>? get body => _body;

  @override
  T parseResponse(dynamic data) {
    if (data == null) return null as T;
    if (T == AuthResponse) {
      return AuthResponse.fromJson(data as Map<String, dynamic>) as T;
    }
    return data as T;
  }
}

class AuthResponse {
  final String accessToken;
  final String? refreshToken;
  final bool isTemporaryToken;

  const AuthResponse({
    required this.accessToken,
    this.refreshToken,
    required this.isTemporaryToken,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    final accessToken = json['accessToken'] as String?;
    final refreshToken = json['refreshToken'] as String?;
    final isTemporaryToken = json['isTemporaryToken'] as bool?;

    if (accessToken == null || isTemporaryToken == null) {
      throw FormatException(
        'Required fields (accessToken, isTemporaryToken) are missing in the response',
      );
    }

    if (!isTemporaryToken && refreshToken == null) {
      throw FormatException(
        'refreshToken is required for non-temporary tokens',
      );
    }

    return AuthResponse(
      accessToken: accessToken,
      refreshToken: refreshToken,
      isTemporaryToken: isTemporaryToken,
    );
  }
}
