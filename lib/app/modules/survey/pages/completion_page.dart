import 'package:easip_app/app/modules/survey/survey_controller.dart';
import 'package:easip_app/app/modules/survey/survey_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompletionPage extends StatelessWidget {
  final SurveyController controller = Get.find<SurveyController>();

  CompletionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SurveyController>();
    return Scaffold(
      body: Column(
        children: [
          // Main content - centered in the middle of the screen
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Approval Picture
                      Image.asset(
                        SurveyAssets.approvalPicture,
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                        errorBuilder:
                            (context, error, stackTrace) => Container(
                              width: 200,
                              height: 200,
                              color: Colors.grey[200],
                              child: const Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        '조건 분석이 완료되었어요!',
                        style: SurveyAssets.headingStyle.copyWith(
                          fontSize: 24,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '고객님 조건에 맞는 공고만을 지금 바로 추천드릴게요.',
                          style: SurveyAssets.bodyStyle.copyWith(
                            fontSize: 14,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Bottom button area - fixed at the bottom
          SafeArea(
            top: false,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () => controller.submitSurvey(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.home, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      '내 조건에 맞는 공고 보기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
