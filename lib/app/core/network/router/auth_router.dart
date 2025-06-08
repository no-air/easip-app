import 'package:easip_app/app/core/config/env_config.dart';
import 'package:easip_app/app/core/network/api_request.dart';
import 'package:easip_app/app/core/network/auth_request.dart';
import 'package:easip_app/app/modules/survey/model/auth_response.dart';
import 'package:easip_app/app/modules/survey/model/signup_request.dart';

class AuthRouter {
  static ApiRequest<AuthResponse> signIn({
    required AuthProvider provider,
    required String socialToken,
  }) {
    return AuthRequest<AuthResponse>(
      path: '/v1/auth/social/${provider.value}',
      method: HttpMethod.post,
      body: {'socialToken': socialToken},
      fromJson: (json) => AuthResponse.fromJson(json as Map<String, dynamic>),
      requiresAuth: false,
    );
  }

  static ApiRequest<AuthResponse> refresh({required String refreshToken}) {
    return AuthRequest<AuthResponse>(
      path: '/v1/auth/refresh',
      method: HttpMethod.post,
      body: {'refreshToken': refreshToken},
      fromJson: (json) => AuthResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  static ApiRequest<AuthResponse> register(SignupRequest request) {
    return AuthRequest<AuthResponse>(
      path: '/v1/auth/register',
      method: HttpMethod.post,
      body: request.toJson(),
      fromJson: (json) => AuthResponse.fromJson(json as Map<String, dynamic>),
      requiresAuth: true,
    );
  }
}

enum AuthProvider {
  google('GOOGLE'),
  apple('APPLE');

  final String value;
  const AuthProvider(this.value);
}
