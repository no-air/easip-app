import 'package:easip_app/app/core/network/router/auth_router.dart';
import 'package:easip_app/app/modules/survey/model/auth_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  // iOS: Keychain, Android: EncryptedSharedPreferences/Keystore 사용
  static final _storage = FlutterSecureStorage();

  static const _keyAccessToken = 'ACCESS_TOKEN';
  static const _keyRefreshToken = 'REFRESH_TOKEN';
  static const _keyIsTempToken = 'IS_TEMP_TOKEN';

  // 토큰 저장
  static Future<void> saveAuthResponse(AuthResponse resp) async {
    await _storage.write(key: _keyAccessToken, value: resp.accessToken);
    await _storage.write(key: _keyRefreshToken, value: resp.refreshToken);
    await _storage.write(
      key: _keyIsTempToken,
      value: resp.isTemporaryToken.toString(),
    );
  }

  // 저장된 accessToken 꺼내기
  static Future<String?> get accessToken async {
    return await _storage.read(key: _keyAccessToken);
  }

  // 저장된 refreshToken 꺼내기
  static Future<String?> get refreshToken async {
    return await _storage.read(key: _keyRefreshToken);
  }

  // isTemporaryToken 꺼내기
  static Future<bool> get isTemporaryToken async {
    final val = await _storage.read(key: _keyIsTempToken);
    return val == 'true';
  }

  // 로그아웃 시 토큰 지우기
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // AuthResponse 가져오기
  static Future<AuthResponse?> getAuthResponse() async {
    final accessToken = TokenStorage.accessToken;
    if (accessToken == null) return null;

    return AuthResponse(
      accessToken: accessToken.toString(),
      refreshToken: await refreshToken,
      isTemporaryToken: await isTemporaryToken,
    );
  }
}
