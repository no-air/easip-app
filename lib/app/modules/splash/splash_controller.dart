import 'package:easip_app/app/services/auth_service.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    try {
      await AuthService().refresh();
      await Future.delayed(const Duration(seconds: 2));
      Get.offAllNamed(Routes.home);
    } catch (e) {
      await Future.delayed(const Duration(seconds: 2));
      Get.offAllNamed(Routes.onboarding);
    }
  }
}
