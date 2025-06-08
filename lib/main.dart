import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_colors.dart';
import 'app/services/auth_service.dart';
import 'app/core/config/env_config.dart';

WebViewEnvironment? webViewEnvironment;

Future<void> main() async {
  try {
    // Initialize Flutter bindings
    WidgetsFlutterBinding.ensureInitialized();

    // Load environment variables
    await dotenv.load(fileName: ".env");

    // Initialize environment configuration
    await EnvConfig().initialize(
      kDebugMode ? Environment.dev : Environment.prod,
    );

    // Enable Android WebView debugging in debug mode
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
    }

    // Initialize services
    Get.put(AuthService());

    runApp(const App());
  } catch (e, stackTrace) {
    debugPrint('Error during app initialization: $e');
    debugPrint('Stack trace: $stackTrace');
    rethrow;
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
