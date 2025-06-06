import 'package:easip_app/app/modules/post/post_view.dart';
import 'package:get/get.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/onboarding/onboarding_view.dart';
import '../modules/onboarding/onboarding_binding.dart';
import '../modules/onboarding/sign_in_view.dart';
import '../modules/onboarding/sign_in_binding.dart';
import '../modules/my/my_view.dart';
import '../modules/my/my_binding.dart';
import '../modules/announcement/announcement_list_view.dart';
import '../modules/announcement/announcement_list_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: Routes.signin,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.my,
      page: () => const MyView(),
      binding: MyBinding(),
    ),
    GetPage(name: Routes.post, page: () => PostView()),
    GetPage(
      name: Routes.announcementList, 
      page: () => const AnnouncementListView(),
      binding: AnnouncementListBinding(),
    ),
  ];
}