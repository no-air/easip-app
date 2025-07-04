import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/widgets/image_asset.dart';
import '../../core/widgets/social_sign_in_button.dart';
import '../../core/utils/screen_utils.dart';
import 'sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: ScreenUtils.ratioWidth(context, 138),
                  height: ScreenUtils.ratioWidth(context, 128),
                  child: const ImageAsset(
                    imagePath: 'assets/images/onboarding4.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  '어려운 주택 청약을\n쉽게 관리하자',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'plSemiBold',
                    fontSize: 29,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + ScreenUtils.ratioHeight(context, 120),
            left: ScreenUtils.ratioHeight(context, 30),
            right: ScreenUtils.ratioHeight(context, 30),
            child: ElevatedButton(
              onPressed: () => Get.offAllNamed('/survey'), // Navigate to survey page without login
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Continue without login'),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + ScreenUtils.ratioHeight(context, 30),
            left: ScreenUtils.ratioHeight(context, 30),
            right: ScreenUtils.ratioHeight(context, 30),
            child: SocialSignInButton(
              imagePath: 'assets/images/google_sign_in.svg',
              onTap: () => controller.signInWithGoogle(),
            ),
          ),
        ],
      ),
    );
  }
} 