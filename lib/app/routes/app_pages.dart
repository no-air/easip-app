import 'package:easip/app/components/testWebview.dart';
import 'package:easip/app/components/webview.dart';
import 'package:get/get.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/splash/splash_view.dart';
import '../modules/splash/splash_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(name: Routes.WEB_VIEW, page: () => Webview()),
    GetPage(name: Routes.TEST_WEB_VIEW, page: () => TestWebview()),
  ];
} 
