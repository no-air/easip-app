import 'dart:collection';

import 'package:easip_app/app/modules/announcement/alarm_registered_list_binding.dart';
import 'package:easip_app/app/modules/house/house_view.dart';
import 'package:easip_app/app/modules/map/map_binding.dart';
import 'package:easip_app/app/modules/map/map_view.dart';
import 'package:easip_app/app/modules/post/post_view.dart';
import 'package:easip_app/app/modules/survey/pages/pages.dart';
import 'package:get/get.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/onboarding/onboarding_view.dart';
import '../modules/onboarding/onboarding_binding.dart';
import '../modules/onboarding/sign_in_view.dart';
import '../modules/onboarding/sign_in_binding.dart';
import '../modules/survey/survey_binding.dart';
import '../modules/survey/survey_view.dart';
import '../modules/survey/pages/living_area_page.dart';
import '../modules/survey/pages/income_page.dart';
import '../modules/survey/pages/household_page.dart';
import '../modules/survey/pages/assets_page.dart';
import '../modules/survey/pages/interest_areas_page.dart';
import '../modules/announcement/alarm_registered_list_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.map, page: () => MapView(), binding: MapBinding()),
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
      name: Routes.survey,
      page: () => const SurveyView(),
      binding: SurveyBinding(),
      children: [
        GetPage(name: Routes.surveyLivingArea, page: () => LivingAreaPage()),
        GetPage(name: Routes.surveyIncome, page: () => IncomePage()),
        GetPage(name: Routes.surveyHousehold, page: () => HouseholdPage()),
        GetPage(name: Routes.surveyAssets, page: () => AssetsPage()),
        GetPage(
          name: Routes.surveyInterestAreas,
          page: () => InterestAreasPage(),
        ),
        GetPage(
          name: Routes.surveyMarriageStatus,
          page: () => MarriageStatusPage(),
        ),
        GetPage(
          name: Routes.surveyCarOwnership,
          page: () => CarOwnershipPage(),
        ),
        GetPage(name: Routes.surveyTotalAsset, page: () => TotalAssetPage()),
        GetPage(name: Routes.surveyCarAsset, page: () => CarAssetPage()),
        GetPage(name: Routes.surveyCompletion, page: () => CompletionPage()),
      ],
    ),
    GetPage(name: Routes.post, page: () => PostView()),
    GetPage(
      name: Routes.alarmRegistered,
      page: () => const AlarmRegisteredListView(),
      binding: AlarmRegisteredListBinding(),
    ),
    GetPage(name: Routes.house, page: () => HouseView()),
  ];
}
