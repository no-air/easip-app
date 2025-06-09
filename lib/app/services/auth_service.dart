import 'package:easip_app/app/core/network/router/auth_router.dart';
import 'package:easip_app/app/modules/account/token_storage.dart';
import 'package:easip_app/app/modules/survey/model/auth_response.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:easip_app/app/core/network/data_source.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find<AuthService>();
  final _dataSource = Get.find<RemoteDataSource>();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile', 'openid'],
    signInOption: SignInOption.standard,
    serverClientId:
        Platform.isAndroid
            ? '836328638609-f5f6pbblpqt07cb1u48a178ivhd182rk.apps.googleusercontent.com'
            : null,
  );

  final Rx<GoogleSignInAccount?> currentUser = Rx<GoogleSignInAccount?>(null);
  final Rx<GoogleSignInAuthentication?> currentAuth =
      Rx<GoogleSignInAuthentication?>(null);

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      debugPrint('AuthService: Starting Google sign in');
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? auth = await account?.authentication;

      if (account == null) {
        debugPrint('AuthService: Google sign in cancelled or failed');
        return null;
      }

      currentAuth.value = auth;

      if (currentAuth.value?.idToken == null) {
        debugPrint('AuthService: Google ID token is null');
        return null;
      }

      currentUser.value = account;
      debugPrint('AuthService: Google sign in successful - ${account.email}');
      return account;
    } catch (e) {
      debugPrint('AuthService: Google sign in error - $e');
      return null;
    }
  }

  Future<void> signOutWithGoogle() async {
    try {
      debugPrint('AuthService: Starting Google sign out');
      await _googleSignIn.signOut();
      currentUser.value = null;
      currentAuth.value = null;
      debugPrint('AuthService: Google sign out successful');
    } catch (e) {
      debugPrint('AuthService: Google sign out error - $e');
    }
  }

  Future<AuthResponse> refresh() async {
    final refreshToken = await TokenStorage.refreshToken;
    if (refreshToken == null) {
      throw Exception('Refresh token not found');
    }
    final request = AuthRouter.refresh(refreshToken: refreshToken);
    final response = await _dataSource.execute(request);
    if (response == null) throw Exception('Failed to refresh token');
    TokenStorage.saveAuthResponse(response);
    return response;
  }
}
