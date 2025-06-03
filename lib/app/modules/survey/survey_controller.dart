import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SurveyController extends GetxController {
  final RxInt currentPage = 0.obs;
  final RxBool isLastPage = false.obs;

  // Answers for each page
  RxString birthDate = ''.obs;
  RxList<bool> interestAreas = List<bool>.filled(25, false).obs;
  RxString salary = ''.obs;
  
  String get formattedSalary {
    if (salary.value.isEmpty) return '';
    final number = int.tryParse(salary.value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    if (number == 0) return '';
    return '${NumberFormat('#,###', 'ko_KR').format(number)}';
  }
  RxInt? livingArea = RxInt(-1);
  RxInt familyCount = 0.obs;
  RxList<String> familySalaries = <String>[].obs;
  // Marital status ('married', 'engaged', 'single')
  final RxString maritalStatus = ''.obs;
  
  // Car ownership status
  final RxBool hasCar = false.obs;
  // ... add more as needed for 11 pages

  // Example: store all answers in a map for submission
  Map<String, dynamic> get surveyStatus => {
    'birthDate': birthDate.value,
    'interestAreas': interestAreas,
    'salary': salary.value,
    'livingArea': livingArea?.value,
    'familyCount': familyCount.value,
    'familySalaries': familySalaries,
    // ... add more as needed
  };

  void nextPage() {
    if (currentPage.value < 10) {
      currentPage.value++;
      updateNavigationState();
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
      updateNavigationState();
    }
  }

  void updateNavigationState() {
    isLastPage.value = currentPage.value == 10;
  }
  
  void goToMainPage() {
    // Navigate to main page after a short delay
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed('/home'); // Replace with your main route
    });
  }

  void submitSurvey() {
  }
}

