import 'package:get/get.dart';
import 'splash_controller.dart';
import '../../services/auth_service.dart';
import '../../core/network/data_source.dart';
import '../../core/config/env_config.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // EnvConfig가 이미 초기화되어 있다고 가정
    if (!EnvConfig().isInitialized) {
      throw StateError('EnvConfig must be initialized before SplashBinding');
    }
    
    // 서비스들을 한 번에 초기화
    _initializeServices();
    
    // 컨트롤러 초기화
    Get.put(SplashController());
  }

  void _initializeServices() {
    // RemoteDataSource 초기화
    if (!Get.isRegistered<RemoteDataSource>()) {
      Get.put(RemoteDataSource(), permanent: true);
    }
    
    // AuthService 초기화
    if (!Get.isRegistered<AuthService>()) {
      Get.put(AuthService(), permanent: true);
    }
  }
} 
 