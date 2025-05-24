import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/secure_storage_keys.dart';

class AuthService extends GetxService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
    signInOption: SignInOption.standard,  // iOS에서 표준 로그인 방식 사용
  );
  final FlutterSecureStorage  _secureStorage = FlutterSecureStorage();

  final Rx<GoogleSignInAccount?> currentUser = Rx<GoogleSignInAccount?>(null);

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      // 현재 로그인된 계정이 있는지 확인
      final currentAccount = await _googleSignIn.signInSilently();
      if (currentAccount != null) {
        currentUser.value = currentAccount;
        return currentAccount;
      }

      // 새로운 로그인 시도
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) {
        return null;
      }

      final GoogleSignInAuthentication auth = await account.authentication;
      await _secureStorage.write(key: SecureStorageKey.googleAccessToken.value, value: auth.accessToken);
      currentUser.value = account;
      return account;
      } catch (e) {
      debugPrint('AuthService: Google Sign-In Error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      currentUser.value = null;
      await _secureStorage.deleteAll();
    } catch (e) {
      debugPrint('AuthService: Google Sign-In Error: $e');
      rethrow;
    }
  }
}

enum SecureStorageKey {
  googleAccessToken,
}

extension SecureStorageKeyExtension on SecureStorageKey {
  String get value {
    switch (this) {
      case SecureStorageKey.googleAccessToken:
        return 'google_access_token';
    }
  }
}