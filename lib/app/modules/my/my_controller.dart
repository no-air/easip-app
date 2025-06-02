import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyController extends GetxController {
  final isEditMode = false.obs;
  final hasHouse = false.obs;
  final selectedPosition = false.obs;
  final canEdit = true.obs;  // 수정하기 버튼 활성화 상태
  
  // TextEditingControllers
  late TextEditingController dayOfBirthController;
  late TextEditingController mySalaryController;
  late TextEditingController familySalaryController;
  late TextEditingController familyCountController;
  late TextEditingController carPriceController;
  late TextEditingController assetPriceController;

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
    // 초기 날짜 유효성 검사
    validateDate(dayOfBirthController.text);
    // 날짜 변경 리스너 추가
    dayOfBirthController.addListener(() {
      validateDate(dayOfBirthController.text);
    });
  }

  void _initializeControllers() {
    dayOfBirthController = TextEditingController(text: '1999.01.05');
    mySalaryController = TextEditingController(text: '0');
    familySalaryController = TextEditingController(text: '0');
    familyCountController = TextEditingController(text: '0');
    carPriceController = TextEditingController(text: '0');
    assetPriceController = TextEditingController(text: '0');
  }

  @override
  void onClose() {
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
    // TODO: API 호출 등 저장 로직 구현
    isEditMode.value = false;
    Get.snackbar(
      '알림',
      '정보가 저장되었습니다.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void updateHasHouse(bool value) {
    hasHouse.value = value;
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
    
    // 입력된 날짜 문자열에서 숫자만 추출
    final numbers = date.replaceAll(RegExp(r'[^0-9]'), '');
    if (numbers.length != 8) {
      canEdit.value = false;
      return false;
    }
    
    // YYYYMMDD 형식 검증
    final year = int.tryParse(numbers.substring(0, 4));
    final month = int.tryParse(numbers.substring(4, 6));
    final day = int.tryParse(numbers.substring(6, 8));
    
    if (year == null || month == null || day == null) {
      canEdit.value = false;
      return false;
    }
    
    // 유효한 날짜인지 검증
    final isValid = year >= 1900 && year <= 2100 && 
                   month >= 1 && month <= 12 && 
                   day >= 1 && day <= 31;
    
    canEdit.value = isValid;
    return isValid;
  }

  String formatDate(String date) {
    if (date.isEmpty) return '';
    // 입력된 날짜 문자열에서 숫자만 추출
    final numbers = date.replaceAll(RegExp(r'[^0-9]'), '');
    if (numbers.length != 8) return date;
    
    // YYYYMMDD 형식으로 변환
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
