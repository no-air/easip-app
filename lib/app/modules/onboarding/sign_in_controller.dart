import 'package:get/get.dart';

class SignInController extends GetxController {
    final isLoading = false.obs;

    Future<void> signInWithGoogle() async {
        try {
            isLoading.value = true;
            // TODO: 구글 로그인 구현
            // 1. GoogleSignIn 패키지 추가 필요
            // 2. Firebase 설정 필요
            // 3. 구글 로그인 로직 구현
            await Future.delayed(const Duration(seconds: 1)); // 임시 딜레이
            Get.offAllNamed('/home'); // 로그인 성공 후 홈 화면으로 이동
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