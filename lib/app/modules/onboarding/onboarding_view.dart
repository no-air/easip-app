import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/widgets/image_asset.dart';
import '../../core/utils/screen_utils.dart';
import 'onboarding_controller.dart';
import 'sign_in_view.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            children: [
              _buildOnboardingPage(
                'assets/images/onboarding1.svg',
                '쉽게 찾는 청년 주택',
                '복잡한 청약 정보를 한눈에 확인하고\n나에게 맞는 청년주택을 찾아보세요.',
                const Size(261, 261),
              ),
              _buildOnboardingPage(
                'assets/images/onboarding2.svg',
                '놓치지 않는 청약 알림',
                '내 조건에 맞는 청약 일정을 자동으로 알려드려\n기회를 놓치지 않도록 도와드립니다.',
                const Size(197, 202),
              ),
              _buildOnboardingPage(
                'assets/images/onboarding3.svg',
                '맞춤형 청약 가이드',
                '내 조건에 맞는 청약중 가장 일치하는\n오늘의 청약 공고를 추천해드립니다.',
                const Size(197, 232),
              ),
              SignInView(),
            ],
          ),
          Obx(() => controller.currentPage.value < controller.totalPages
            ? Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    controller.totalPages,
                    (index) => Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.currentPage.value == index
                          ? Theme.of(context).primaryColor
                          : Colors.grey.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(String imagePath, String title, String description, Size baseSize) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageSize = Size(
          ScreenUtils.ratioWidth(context, baseSize.width),
          ScreenUtils.ratioWidth(context, baseSize.height),
        );
        
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints.tight(imageSize),
              child: ImageAsset(
                imagePath: imagePath,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'plBold',
                fontSize: 29,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'plMedium',
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        );
      },
    );
  }
}