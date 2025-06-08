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
