import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_colors.dart';
import 'app/services/auth_service.dart';
import 'app/core/network/data_source.dart';
import 'app/core/config/env_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // 1. 환경 변수 로드
    await dotenv.load(fileName: ".env");
    
    // 2. EnvConfig 초기화
    final envConfig = EnvConfig();
    await envConfig.initialize(Environment.dev);
    
    // 3. 서비스 초기화
    final authService = AuthService();
    Get.put(authService, permanent: true);
    
    final dataSource = RemoteDataSource();
    Get.put(dataSource, permanent: true);
    
    // 4. 앱 실행
    runApp(const App());
  } catch (e, stackTrace) {
    debugPrint('Initialization error: $e');
    debugPrint('Stack trace: $stackTrace');
    // 초기화 실패 시에도 앱은 실행
    runApp(const App());
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Easip',
      theme: ThemeData(
        primaryColor: AppColors.eRed,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: AppRoutes.initial,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
