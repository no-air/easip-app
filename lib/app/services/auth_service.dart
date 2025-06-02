import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;

class AuthService extends GetxService {
  static AuthService get to => Get.find<AuthService>();
  
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile', 'openid'],
    signInOption: SignInOption.standard,
    serverClientId: Platform.isAndroid ? '836328638609-f5f6pbblpqt07cb1u48a178ivhd182rk.apps.googleusercontent.com' : null,
  );
  
  final Rx<GoogleSignInAccount?> currentUser = Rx<GoogleSignInAccount?>(null);
  final Rx<GoogleSignInAuthentication?> currentAuth = Rx<GoogleSignInAuthentication?>(null);

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      debugPrint('AuthService: Starting Google sign in');
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      
      if (account == null) {
        debugPrint('AuthService: Google sign in cancelled or failed');
        return null;
      }

      final GoogleSignInAuthentication auth = await account.authentication;
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
}