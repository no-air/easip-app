import 'package:get/get.dart';
import 'my_controller.dart';
import '../onboarding/sign_in_controller.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MyController());
    Get.put(SignInController());
  }
} 