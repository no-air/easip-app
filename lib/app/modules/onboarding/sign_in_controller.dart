import 'package:easip_app/app/modules/account/token_storage.dart';
import 'package:get/get.dart';
import '../../services/auth_service.dart';
import 'package:easip_app/app/core/network/router/auth_router.dart';
import 'package:easip_app/app/core/network/data_source.dart';
import 'package:dio/dio.dart';

class SignInController extends GetxController {
  late final AuthService _authService;
  late final RemoteDataSource _dataSource;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _authService = AuthService.to;
    _dataSource = RemoteDataSource.to;
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      final account = await _authService.signInWithGoogle();
      // TokenStorage에 저장

      if (account != null) {
        await signInEasip();
      } else {
        Get.snackbar(
          '로그인 실패',
          '구글 로그인 중 오류가 발생했습니다',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        '로그인 실패',
        '구글 로그인 중 오류가 발생했습니다',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInEasip() async {
    try {
      // 1. Get Google ID token
      final token = _authService.currentAuth.value?.idToken;

      // 2. If no token, try to refresh
      if (token == null) {
        await _handleTokenRefresh();
        return;
      }

      // 3. Validate token format before sending
      if (!_isValidToken(token)) {
        throw Exception('유효하지 않은 토큰 형식입니다. 다시 로그인해주세요.');
      }

      // 4. Proceed with normal sign-in
      await _performSignIn(token);
    } on DioException catch (e) {
      final errorMessage = _handleDioError(e);
      _showErrorSnackbar('로그인 실패', errorMessage);
    } catch (e, _) {
      _showErrorSnackbar(
        '오류 발생',
        '알 수 없는 오류가 발생했습니다: ${e.toString().split('.').first}', // Show first sentence only
      );
    }
  }

  Future<void> _handleTokenRefresh() async {
    try {
      final refreshToken = await TokenStorage.refreshToken;

      if (refreshToken == null) {
        throw Exception('로그인 세션이 만료되었습니다. 다시 로그인해주세요.');
      }

      if (!_isValidToken(refreshToken)) {
        throw Exception('유효하지 않은 리프레시 토큰입니다. 다시 로그인해주세요.');
      }

      final refreshRequest = AuthRouter.refresh(refreshToken: refreshToken);
      final refreshResponse = await _dataSource.execute(refreshRequest);

      if (refreshResponse == null) {
        throw Exception('서버에서 응답을 받지 못했습니다. 네트워크 상태를 확인해주세요.');
      }

      final authResponse = AuthResponse.fromJson(
        refreshResponse as Map<String, dynamic>,
      );

      await _saveAndVerifyTokens(authResponse);
      _navigateAfterLogin();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _performSignIn(String token) async {
    try {
      final request = AuthRouter.signIn(
        provider: AuthProvider.google,
        socialToken: token,
      );

      final response = await _dataSource.execute(request);

      if (response == null) {
        throw Exception('서버에서 응답을 받지 못했습니다. 잠시 후 다시 시도해주세요.');
      }

      final authResponse = AuthResponse.fromJson(
        response as Map<String, dynamic>,
      );

      await _saveAndVerifyTokens(authResponse);
      _navigateAfterLogin();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _saveAndVerifyTokens(AuthResponse authResponse) async {
    try {
      await TokenStorage.saveAuthResponse(authResponse);

      final savedAccessToken = await TokenStorage.accessToken;
      final savedRefreshToken = await TokenStorage.refreshToken;

      if (savedAccessToken == null) {
        throw Exception('액세스 토큰을 저장하지 못했습니다.');
      }
      if (authResponse.refreshToken != null && savedRefreshToken == null) {
        throw Exception('리프레시 토큰을 저장하지 못했습니다.');
      }
    } catch (e) {
      throw Exception('토큰 저장 중 오류가 발생했습니다. 다시 시도해주세요.');
    }
  }

  bool _isValidToken(String? token) {
    if (token == null || token.isEmpty) return false;
    // Basic JWT validation (checks if it has 3 parts separated by dots)
    final parts = token.split('.');
    return parts.length == 3;
  }

  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
    );
  }
}

// Helper method to navigate after successful login
void _navigateAfterLogin() {
  Get.offAllNamed('/home');
}

// Handle Dio specific errors
String _handleDioError(DioException e) {
  if (e.response != null) {
    switch (e.response?.statusCode) {
      case 400:
        return '잘못된 요청입니다.';
      case 401:
        return '인증에 실패했습니다. 다시 로그인해주세요.';
      case 403:
        return '접근 권한이 없습니다.';
      case 404:
        return '요청하신 리소스를 찾을 수 없습니다.';
      case 429:
        return '너무 많은 요청이 발생했습니다. 잠시 후 다시 시도해주세요.';
      case 500:
      case 502:
      case 503:
        return '서버에 문제가 발생했습니다. 잠시 후 다시 시도해주세요.';
      default:
        return '네트워크 오류가 발생했습니다. (${e.response?.statusCode})';
    }
  } else {
    // Handle other Dio error types
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return '네트워크 연결이 불안정합니다. 연결 상태를 확인해주세요.';
      case DioExceptionType.cancel:
        return '요청이 취소되었습니다.';
      case DioExceptionType.unknown:
        return '네트워크 연결에 실패했습니다. 인터넷 연결을 확인해주세요.';
      default:
        return '알 수 없는 오류가 발생했습니다: ${e.message}';
    }
  }
}
