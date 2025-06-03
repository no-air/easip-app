import 'package:get/get.dart';
import 'sign_in_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    // SignInController는 항상 새로 생성
    Get.put(SignInController());
  }
} 