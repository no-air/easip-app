import 'package:get/get.dart';
import '../../services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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
            debugPrint('SignInController: Starting Google sign in');
            
            final account = await _authService.signInWithGoogle();
            if (account != null) {
                await signInEasip();
            }
        } catch (e) {
            debugPrint('SignInController: Google sign in failed - $e');
            // Get.snackbar(
            //     '로그인 실패',
            //     '구글 로그인 중 오류가 발생했습니다: ${e.toString()}',
            //     snackPosition: SnackPosition.BOTTOM,
            // );
        } finally {
            isLoading.value = false;
        }
    }

    Future<void> signInEasip() async {
        try {
            final token = _authService.currentAuth.value?.idToken;
            if (token == null) {
                throw Exception('Google token not found');
            }
            
            debugPrint('SignInController: Starting Easip sign in with token');
            final request = AuthRouter.signIn(
                provider: AuthProvider.google, 
                socialToken: token
            );
            
            final response = await _dataSource.execute(request);
            if (response == null) {
                throw Exception('서버 응답이 없습니다');
            }
            
            debugPrint('SignInController: Easip sign in successful');
        } catch (e) {
            debugPrint('SignInController: Easip sign in failed - $e');
            if (e is DioException) {
                debugPrint('SignInController: Server error - ${e.response?.statusCode}');
            }
            // Get.snackbar(
            //     '로그인 실패', 
            //     '서버 로그인 중 오류가 발생했습니다: ${e.toString()}', 
            //     snackPosition: SnackPosition.BOTTOM
            // );
        }
    }
} 