import 'package:get/get.dart';
import '../../services/auth_service.dart';

class SignInController extends GetxController {
    late final AuthService _authService;
    final isLoading = false.obs;

    @override
    void onInit() {
        super.onInit();
        _authService = Get.find<AuthService>();
    }

    Future<void> signInWithGoogle() async {
        try {
            // isLoading.value = true;
            // final account = await _authService.signInWithGoogle();
            
            // if (account != null) {
            //     Get.offAllNamed('/home');
            // }
            // survey page
            Get.offAllNamed('/survey'); 
        } catch (e) {
            Get.snackbar(
                '로그인 실패',
                '구글 로그인 중 오류가 발생했습니다: ${e.toString()}',
                snackPosition: SnackPosition.BOTTOM,
            );
        } finally {
            isLoading.value = false;
        }
    }
}