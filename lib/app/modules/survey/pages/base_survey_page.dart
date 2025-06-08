import 'package:easip_app/app/modules/survey/survey_assets.dart';
import 'package:easip_app/app/modules/survey/survey_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../survey_controller.dart';

class BaseSurveyPage extends StatefulWidget {
  final int currentStep;
  final int totalSteps;
  final String title;
  final Widget child;
  final bool showBackButton;
  final bool showSkipButton;
  final bool showNextButton;
  final bool isNextEnabled;
  final String nextButtonText;
  final VoidCallback? onNextPressed;
  final VoidCallback? onSkipPressed;
  final SurveyController controller;

  const BaseSurveyPage({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    required this.title,
    required this.child,
    required this.controller,
    this.showBackButton = true,
    this.showSkipButton = false,
    this.showNextButton = true,
    this.isNextEnabled = true,
    this.nextButtonText = '다음',
    this.onNextPressed,
    this.onSkipPressed,
  }) : super(key: key);

  @override
  _BaseSurveyPageState createState() => _BaseSurveyPageState();
}

class _BaseSurveyPageState extends State<BaseSurveyPage> {
  final SurveyController controller = Get.find<SurveyController>();

  @override
  void dispose() {
    // No need to dispose the controller as it's managed by GetX
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with back button and skip button
                  SizedBox(
                    height: 48, // Match the height of the row
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Back button (aligned to start)
                        if (widget.showBackButton)
                          Positioned(
                            left: 0,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios, size: 20),
                              onPressed: () {
                                final currentStep = widget.currentStep;
                                if (currentStep > 1) {
                                  widget.controller.previousPage();
                                }
                              },
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ),
                        // ProgressDots (centered)
                        Align(
                          alignment: Alignment.center,
                          child: ProgressDots(
                            total: widget.totalSteps,
                            current: widget.currentStep,
                          ),
                        ),
                        // Skip button (aligned to end, conditionally shown)
                        if (widget.showSkipButton)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: widget.controller.nextPage,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(60, 36),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),

                              // style: TextButton.styleFrom(
                              //   padding: EdgeInsets.zero,
                              //   minimumSize: const Size(60, 36),
                              //   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              // ),
                              child: const Text(
                                '건너뛰기',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Title
                  Center(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        // Paperlogy Semibold
                        fontFamily: 'PaperlogySemibold',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: widget.child),
          ],
        ),
      ),
      bottomNavigationBar:
          widget.showNextButton
              ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: SurveyButton(
                  text: '다음',
                  onTap: widget.onNextPressed ?? controller.nextPage,
                  enabled: widget.isNextEnabled,
                ),
              )
              : const SizedBox.shrink(),
    );
  }
}
