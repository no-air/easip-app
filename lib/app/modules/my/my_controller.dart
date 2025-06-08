import 'package:easip_app/app/core/network/router/easip_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'models/user_profile_response.dart';
import 'package:easip_app/app/core/network/data_source.dart';
import 'package:easip_app/app/modules/my/models/user_profile_request.dart';
import 'models/districts_response.dart';

class MyController extends GetxController {
  late final RemoteDataSource _dataSource;

  final isEditMode = false.obs;
  final hasHouse = false.obs;
  final selectedPosition = false.obs;
  final canEdit = true.obs;
  final userProfile = Rxn<UserProfileResponse>();
  final isDeleted = false.obs;

  final districts = Rxn<DistrictResponse>();
  final livingArea = RxnInt();
  final likingAreas = <bool>[].obs;

  // TextEditingControllers
  late TextEditingController nameController;
  late TextEditingController dayOfBirthController;
  late TextEditingController mySalaryController;
  late TextEditingController familySalaryController;
  late TextEditingController familyCountController;
  late TextEditingController carPriceController;
  late TextEditingController assetPriceController;

  @override
  void onInit() {
    super.onInit();
    _dataSource = Get.find<RemoteDataSource>();
    _initializeControllers();
    canEdit.value = true;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await _getMyInformation();
  }

  Future<void> _getMyInformation() async {
    try {
      final request = await EasipRouter.getMyProfile();
      final response = await _dataSource.execute(request);

      if (response == null) {
        throw Exception('서버에서 응답을 받지 못했습니다. 잠시 후 다시 시도해주세요.');
      }

      userProfile.value = response;
      _updateControllersFromModel();
      canEdit.value = true;
    } catch (e) {
      debugPrint(e.toString());
      canEdit.value = false;
    }
  }

  Future<void> deleteAccount() async {
    try {
      final request = await EasipRouter.deleteAccount();
      final response = await _dataSource.execute(request);

      if (response == null) {
        throw Exception('서버에서 응답을 받지 못했습니다. 잠시 후 다시 시도해주세요.');
      }

      if (response.success) {
        isDeleted.value = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> _putProfile(UserProfileRequest profileRequest) async {
    try {
      final request = await EasipRouter.putMyProfile(profileRequest);
      final response = await _dataSource.execute(request);

      if (response == null) {
        throw Exception('서버에서 응답을 받지 못했습니다. 잠시 후 다시 시도해주세요.');
      }

      return response.success;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> getDistrictList() async {
    try {
      final request = await EasipRouter.getDistrictList();
      final response = await _dataSource.execute(request);

      if (response == null) {
        throw Exception('서버에서 응답을 받지 못했습니다. 잠시 후 다시 시도해주세요.');
      }

      districts.value = response;
    } catch (e) {
      debugPrint(e.toString());
      canEdit.value = false;
    }
  }

  void _updateControllersFromModel() {
    if (userProfile.value != null) {
      final info = userProfile.value!;
      nameController.text = info.name;
      dayOfBirthController.text = info.dayOfBirth
          .toIso8601String()
          .split('T')[0]
          .replaceAll('-', '');
      mySalaryController.text = info.myMonthlySalary.toString();
      familySalaryController.text = info.familyMemberMonthlySalary.toString();
      familyCountController.text = info.allFamilyMemberCount.toString();
      carPriceController.text = info.carPrice.toString();
      assetPriceController.text = info.assetPrice.toString();
      selectedPosition.value = info.position == UserPosition.youngMan;
    }
  }

  void _initializeControllers() {
    nameController = TextEditingController();
    dayOfBirthController = TextEditingController();
    mySalaryController = TextEditingController();
    familySalaryController = TextEditingController();
    familyCountController = TextEditingController();
    carPriceController = TextEditingController();
    assetPriceController = TextEditingController();
  }

  @override
  void onClose() {
    nameController.dispose();
    dayOfBirthController.dispose();
    mySalaryController.dispose();
    familySalaryController.dispose();
    familyCountController.dispose();
    carPriceController.dispose();
    assetPriceController.dispose();
    super.onClose();
  }

  void toggleEditMode() {
    if (!canEdit.value) return;
    isEditMode.value = !isEditMode.value;
  }

  void saveChanges() async {
    if (userProfile.value == null) return;

    // 날짜 포맷팅 (YYYY-MM-DD)
    final birthDateStr = dayOfBirthController.text.padLeft(8, '0');
    final year = birthDateStr.substring(0, 4);
    final month = birthDateStr.substring(4, 6);
    final day = birthDateStr.substring(6, 8);
    final formattedDate = '$year-$month-$day'; // YYYY-MM-DD 형식

    final updatedInfo = UserProfileResponse(
      name: nameController.text,
      likingPostCount: userProfile.value!.likingPostCount,
      dayOfBirth: DateTime.parse(formattedDate),
      likingDistrictIds: userProfile.value?.likingDistrictIds ?? [],
      livingDistrictId: userProfile.value?.livingDistrictId ?? "",
      myMonthlySalary: int.tryParse(mySalaryController.text) ?? 0,
      familyMemberMonthlySalary: int.tryParse(familySalaryController.text) ?? 0,
      allFamilyMemberCount: int.tryParse(familyCountController.text) ?? 0,
      position:
          selectedPosition.value
              ? UserPosition.youngMan
              : UserPosition.newlywed,
      hasCar: (int.tryParse(carPriceController.text) ?? 0) > 0,
      carPrice: int.tryParse(carPriceController.text) ?? 0,
      assetPrice: int.tryParse(assetPriceController.text) ?? 0,
    );

    final livingDistrictName = userProfile.value?.livingDistrictId ?? "";
    final livingDistrictId =
        districts.value?.findByName(livingDistrictName)?.id ?? '';
    final likingDistrictNames = userProfile.value?.likingDistrictIds ?? [];
    final likingDistrictIds =
        districts.value?.getDistrictNames(likingDistrictNames) ?? [];

    // Request도 YYYY-MM-DD 형식 사용
    final request = UserProfileRequest(
      name: updatedInfo.name,
      dayOfBirth: formattedDate,
      livingDistrictId: livingDistrictId,
      likingDistrictIds: likingDistrictIds,
      myMonthlySalary: updatedInfo.myMonthlySalary,
      familyMemberMonthlySalary: updatedInfo.familyMemberMonthlySalary,
      allFamilyMemberCount: updatedInfo.allFamilyMemberCount,
      position:
          updatedInfo.position == UserPosition.youngMan
              ? 'YOUNG_MAN'
              : 'NEWLYWED',
      carPrice: updatedInfo.carPrice,
      assetPrice: updatedInfo.assetPrice,
      hasCar: updatedInfo.hasCar,
    );

    final validationErrors = request.getValidationErrors();
    if (validationErrors.isNotEmpty) {
      Get.snackbar(
        '입력 오류',
        validationErrors.join('\n'),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
      return;
    }

    try {
      final result = await _putProfile(request);

      if (result) {
        userProfile.value = updatedInfo;
        isEditMode.value = false; // 성공했을 때만 수정 모드 종료
        Get.snackbar(
          '알림',
          '정보가 저장되었습니다.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          '오류',
          '정보 저장에 실패했습니다.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        '오류',
        '정보 저장 중 오류가 발생했습니다.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void updateDayOfBirth(String value) {
    dayOfBirthController.text = value;
  }

  void updatePosition(bool value) {
    selectedPosition.value = value;
  }

  String formatPrice(int? price) {
    if (price == null) return '0';
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  String formatDate(String date) {
    if (date.isEmpty) return '';
    final numbers = date.replaceAll(RegExp(r'[^0-9]'), '');
    if (numbers.length != 8) return date;

    return '${numbers.substring(0, 4)}.${numbers.substring(4, 6)}.${numbers.substring(6, 8)}';
  }

  void initLikingAreas() {
    final districtsName = districts.value?.names ?? [];
    final selected = userProfile.value?.likingDistrictIds ?? [];

    likingAreas.value = List.generate(
      districtsName.length,
      (i) => selected.contains(districtsName[i]),
    );
  }

  void updateLikingDistrict() {
    final districtsName = districts.value?.names ?? [];
    final selected = <String>[];
    for (int i = 0; i < likingAreas.length; i++) {
      if (likingAreas[i]) selected.add(districtsName[i]);
    }
    if (userProfile.value != null) {
      userProfile.value = userProfile.value!.copyWith(
        likingDistrictIds: selected,
      );
    }
  }
}
