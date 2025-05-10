import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    
    _navigateToNavigation();
  }

  Future<void> _navigateToNavigation() async {
    // await Future.delayed(const Duration(seconds: 2));
    await Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(Routes.NAVIGATION);
    });
  }
} 