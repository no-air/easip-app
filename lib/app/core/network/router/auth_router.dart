import 'package:easip_app/app/constants/secure_storage_keys.dart';
import 'package:easip_app/app/core/config/env_config.dart';
import 'package:easip_app/app/core/network/api_request.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final bool isTemporaryToken;

  const AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.isTemporaryToken,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
    isTemporaryToken: json['isTemporaryToken'] as bool,
  );
}

enum AuthProvider {
  google('GOOGLE'),
  apple('APPLE');
  
  final String value;
  const AuthProvider(this.value);
}

class AuthRouter {
  static ApiRequest<AuthResponse> signIn({
    required AuthProvider provider,
    required String socialToken,
  }) {
    return _AuthRequest<AuthResponse>(
      path: '/v1/auth/social/${provider.value}',
      method: HttpMethod.post,
      body: {'socialToken': socialToken},
    );
  }
}

class _AuthRequest<T> extends ApiRequest<T> {
  final String _path;
  final HttpMethod _method;
  final Map<String, dynamic>? _body;

  _AuthRequest({
    required String path,
    required HttpMethod method,
    Map<String, dynamic>? body,
  })  : _path = path,
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
    return data as T;
  }
}
