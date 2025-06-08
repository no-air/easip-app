import 'package:get/get.dart';
import 'splash_controller.dart';
import '../../services/auth_service.dart';
import '../../core/network/data_source.dart';
import '../../core/config/env_config.dart';

class SplashBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    // EnvConfig가 이미 초기화되어 있다고 가정
    if (!EnvConfig().isInitialized) {
      throw StateError('EnvConfig must be initialized before SplashBinding');
    }

    // 서비스 초기화
    if (!Get.isRegistered<RemoteDataSource>()) {
      Get.put(RemoteDataSource(), permanent: true);
    }

    if (!Get.isRegistered<AuthService>()) {
      Get.put(AuthService(), permanent: true);
    }

    // 컨트롤러 초기화
    Get.put(SplashController());
  }
}
