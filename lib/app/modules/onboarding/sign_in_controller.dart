import 'package:get/get.dart';

class SignInController extends GetxController {
    final isLoading = false.obs;

    Future<void> signInWithGoogle() async {
        try {
            isLoading.value = true;
            // TODO: 구글 로그인 구현
            await Future.delayed(const Duration(seconds: 1));
            Get.offAllNamed('/home'); 
        } catch (e) {
            Get.snackbar(
                '로그인 실패',
                '구글 로그인 중 오류가 발생했습니다.',
                snackPosition: SnackPosition.BOTTOM,
            );
        } finally {
            isLoading.value = false;
        }
    }
} 