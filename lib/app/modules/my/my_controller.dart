import 'package:easip_app/app/core/network/router/my_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'models/personal_information_model.dart';
import 'package:easip_app/app/core/network/data_source.dart';

class MyController extends GetxController {
  late final RemoteDataSource _dataSource;

  final isEditMode = false.obs;
  final hasHouse = false.obs;
  final selectedPosition = false.obs;
  final canEdit = true.obs; 
  final personalInfo = Rxn<PersonalInformationModel>();
  
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
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await _getMyInformation();
  }

  Future<void> _getMyInformation() async {
    try {
      final request = await EasipRouter.getMyInformation();
      final response = await _dataSource.execute(request);

      if (response == null) {
        throw Exception('서버에서 응답을 받지 못했습니다. 잠시 후 다시 시도해주세요.');
      }

      personalInfo.value = response;  
      _updateControllersFromModel();    
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _updateControllersFromModel() {
    if (personalInfo.value != null) {
      final info = personalInfo.value!;
      nameController.text = info.name;
      dayOfBirthController.text = info.dayOfBirth;
      mySalaryController.text = info.myMonthlySalary.toString();
      familySalaryController.text = info.familyMemberMonthlySalary.toString();
      familyCountController.text = info.allFamilyMemberCount.toString();
      carPriceController.text = info.carPrice.toString();
      assetPriceController.text = info.assetPrice.toString();
      selectedPosition.value = info.position == 'YOUNG_MAN';
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

    // 날짜 변경 리스너 추가
    dayOfBirthController.addListener(() {
      validateDate(dayOfBirthController.text);
    });
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
    isEditMode.value = !isEditMode.value;
  }

  void saveChanges() {
    if (personalInfo.value != null) {
      final updatedInfo = PersonalInformationModel(
        name: nameController.text,
        dayOfBirth: dayOfBirthController.text,
        likingDistrictIds: personalInfo.value!.likingDistrictIds,
        livingDistrictId: personalInfo.value!.livingDistrictId,
        myMonthlySalary: int.tryParse(mySalaryController.text) ?? 0,
        familyMemberMonthlySalary: int.tryParse(familySalaryController.text) ?? 0,
        allFamilyMemberCount: int.tryParse(familyCountController.text) ?? 0,
        position: selectedPosition.value ? 'YOUNG_MAN' : 'NEWLYWED',
        hasCar: (carPriceController.text == '0') ? false: true,
        carPrice: int.tryParse(carPriceController.text) ?? 0,
        assetPrice: int.tryParse(assetPriceController.text) ?? 0,
      );
      
      personalInfo.value = updatedInfo;
      nameController.text = updatedInfo.name;
    }
    
    isEditMode.value = false;
    // Get.snackbar(
    //   '알림',
    //   '정보가 저장되었습니다.',
    //   snackPosition: SnackPosition.BOTTOM,
    // );
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
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  bool validateDate(String date) {
    if (date.isEmpty) {
      canEdit.value = false;
      return false;
    }
    
    final numbers = date.replaceAll(RegExp(r'[^0-9]'), '');
    if (numbers.length != 8) {
      canEdit.value = false;
      return false;
    }
    
    final year = int.tryParse(numbers.substring(0, 4));
    final month = int.tryParse(numbers.substring(4, 6));
    final day = int.tryParse(numbers.substring(6, 8));
    
    if (year == null || month == null || day == null) {
      canEdit.value = false;
      return false;
    }
    
    final isValid = year >= 1900 && year <= 2100 && 
                   month >= 1 && month <= 12 && 
                   day >= 1 && day <= 31;
    
    canEdit.value = isValid;
    return isValid;
  }

  String formatDate(String date) {
    if (date.isEmpty) return '';
    final numbers = date.replaceAll(RegExp(r'[^0-9]'), '');
    if (numbers.length != 8) return date;
    
    final year = numbers.substring(0, 4);
    final month = numbers.substring(4, 6);
    final day = numbers.substring(6, 8);
    
    return '$year.$month.$day';
  }

  String getDistrictName(String? districtId) {
    if (districtId == null || districtId.isEmpty) return '기타';
    return '감사구';
  }

  List<String> getDistrictNames(List<String>? districtIds) {
    if (districtIds == null || districtIds.isEmpty) {
      return ['감사구', '미포구', '개총구'];
    }
    return districtIds.map((id) => getDistrictName(id)).toList();
  }
} 