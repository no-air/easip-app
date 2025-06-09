import 'package:easip_app/app/services/auth_service.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import 'package:easip_app/app/modules/account/token_storage.dart';
import 'package:flutter/foundation.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    try {
      final token = await TokenStorage.accessToken;
      debugPrint('Tokentokentoken: $token');
      if (token == null || token.isEmpty) {
        await Future.delayed(const Duration(seconds: 2));
         debugPrint('Token 없음');
        Get.offAllNamed(Routes.onboarding);
        return;
      }

      // 토큰이 있으면 refresh 시도
      try {
        await AuthService().refresh();
        await Future.delayed(const Duration(seconds: 2));
        Get.offAllNamed(Routes.home);
      } catch (e) {
        // refresh 실패 시 토큰이 만료되었거나 유효하지 않으므로 온보딩으로 이동
        debugPrint('Token refresh failed: $e');
        await Future.delayed(const Duration(seconds: 2));
        Get.offAllNamed(Routes.onboarding);
      }
    } catch (e) {
      await Future.delayed(const Duration(seconds: 2));
      Get.offAllNamed(Routes.onboarding);
    }
  }
}
