import 'package:easip_app/app/core/network/router/auth_router.dart';
import 'package:easip_app/app/modules/account/token_storage.dart';
import 'package:easip_app/app/modules/survey/model/signup_request.dart';
import 'package:easip_app/app/modules/survey/model/auth_response.dart';
import 'package:easip_app/app/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:easip_app/app/core/network/data_source.dart';

// survey_controller.dart
class SurveyController extends GetxController {
  final RemoteDataSource _dataSource = Get.find<RemoteDataSource>();
  // Page Management
  final RxInt currentPage = 0.obs;
  final RxBool isLastPage = false.obs;
  final RxBool isLoading = false.obs;

  // Page 1: Birth Date
  final Rx<DateTime?> birthDate = Rx<DateTime?>(null);

  // Page 2: Interest Areas
  final RxList<String> interestAreaIds = <String>[].obs;

  // Page 3: Living Area
  final RxList<String> livingDistrictIds = <String>[].obs;

  // Page 4: Assets
  final RxInt income = 0.obs;

  // Page 5: Household Size
  final RxInt householdSize = 0.obs;

  // Page 6: Family Salaries
  final RxList<int> familySalaries = <int>[].obs;
  final RxInt totalAssets = 0.obs;

  // Page 7: Marriage Status
  final RxString marriageStatus = ''.obs;

  // Page 8: Car Ownership
  final RxBool hasCar = false.obs;

  // Page 9: Car Asset (if hasCar is true)
  final RxInt carAsset = 0.obs;

  // Navigation
  void nextPage() {
    if (currentPage.value < 10) {
      currentPage.value++;
    }
    updateNavigationState();
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
    updateNavigationState();
  }

  void updateNavigationState() {
    isLastPage.value = currentPage.value == 10; // Last page is index 9
  }

  // Toggle interest area selection
  void toggleInterestArea(String areaId) {
    if (interestAreaIds.contains(areaId)) {
      interestAreaIds.remove(areaId);
    } else {
      interestAreaIds.add(areaId);
    }
  }

  // Toggle living district selection
  void toggleLivingDistrict(String districtId) {
    if (livingDistrictIds.contains(districtId)) {
      livingDistrictIds.remove(districtId);
    } else {
      livingDistrictIds.add(districtId);
    }
  }

  Future<void> submitSurvey() async {
    try {
      isLoading.value = true;

      // Convert marriage status to position
      String getPosition() {
        switch (marriageStatus.value) {
          case 'married':
            return 'NEWLY_MARRIED_COUPLE';
          case 'engaged':
            return 'PRE_NEWLY_MARRIED_COUPLE';
          default:
            return 'YOUNG_MAN';
        }
      }

      // Calculate total family salary
      final totalFamilySalary = familySalaries.fold<int>(
        0,
        (sum, salary) => sum + (salary ?? 0),
      );

      final request = SignupRequest(
        name: await _getUserName(),
        dayOfBirth: birthDate.value?.toIso8601String().split('T').first ?? '',
        likingDistrictIds: interestAreaIds,
        livingDistrictId:
            livingDistrictIds.isNotEmpty
                ? livingDistrictIds.first
                : (interestAreaIds.isNotEmpty ? interestAreaIds.first : ''),
        myMonthlySalary: income.value,
        familyMemberMonthlySalary: totalFamilySalary,
        allFamilyMemberCount: householdSize.value + 1,
        position: getPosition(),
        hasCar: hasCar.value,
        carPrice: hasCar.value ? carAsset.value : 0,
        assetPrice: totalAssets.value,
      );

      final response = await _dataSource.execute<AuthResponse>(
        AuthRouter.register(request),
      );
      if (response != null) {
        final authResponse = response;
        await TokenStorage.saveAuthResponse(authResponse);
        Get.offAllNamed(Routes.home);
      } else {
        throw Exception('Failed to register: Response is null');
      }
    } catch (e) {
      Get.snackbar('오류', '회원가입 중 오류가 발생했습니다: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void updateLivingDistrict(String id) {
    livingDistrictIds.add(id);
  }

  _getUserName() {
    return "나나미";
  }
}
