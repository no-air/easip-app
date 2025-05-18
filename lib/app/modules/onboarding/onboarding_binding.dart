import 'package:get/get.dart';
import 'onboarding_controller.dart';
import 'sign_in_controller.dart';

class OnboardingBinding extends Bindings {
    @override
    void dependencies() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
        Get.lazyPut<SignInController>(() => SignInController());
    }
}