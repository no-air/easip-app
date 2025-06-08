import 'package:easip_app/app/modules/survey/survey_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import all pages with consistent naming
import 'pages/birth_date_page.dart' as birth_date_page;
import 'pages/interest_areas_page.dart' as interest_areas_page;
import 'pages/living_area_page.dart' as living_area_page;
import 'pages/assets_page.dart' as assets_page;
import 'pages/household_page.dart' as household_page;
import 'pages/family_salaries_page.dart' as family_salaries_page;
import 'pages/marriage_status_page.dart' as marriage_status_page;
import 'pages/car_ownership_page.dart' as car_ownership_page;
import 'pages/car_asset_page.dart' as car_asset_page;
import 'pages/total_asset_page.dart' as total_asset_page;
import 'pages/completion_page.dart' as completion_page;

// survey_view.dart
class SurveyView extends GetView<SurveyController> {
  const SurveyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() => _buildPage(controller.currentPage.value)));
  }

  Widget _buildPage(int page) {
    switch (page) {
      case 0:
        return birth_date_page.BirthDatePage();
      case 1:
        return const interest_areas_page.InterestAreasPage();
      case 2:
        return const living_area_page.LivingAreaPage();
      case 3:
        return const assets_page.AssetsPage();
      case 4:
        return const household_page.HouseholdPage();
      case 5:
        return family_salaries_page.FamilySalariesPage();
      case 6:
        return marriage_status_page.MarriageStatusPage();
      case 7:
        return car_ownership_page.CarOwnershipPage();
      case 8:
        return car_asset_page.CarAssetPage();
      case 9:
        return total_asset_page.TotalAssetPage();
      case 10:
        return completion_page.CompletionPage();
      default:
        return const Center(child: Text('페이지를 찾을 수 없습니다.'));
    }
  }

  bool _isCurrentPageValid(int page) {
    final controller = Get.find<SurveyController>();
    switch (page) {
      case 0:
        return controller.birthDate.value != null;
      case 1:
        return controller.interestAreaIds.isNotEmpty;
      case 2:
        return controller.livingDistrictIds.isNotEmpty;
      case 4:
        return controller.householdSize.value > 0;
      case 6:
        return controller.marriageStatus.value.isNotEmpty;
      case 7:
        return controller.hasCar.value != null;
      case 8:
        return !controller.hasCar.value || controller.carAsset.value > 0;
      case 9:
        return controller.totalAssets.value > 0;
      default:
        return true;
    }
  }
}
