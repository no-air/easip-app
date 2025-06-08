import 'package:easip_app/app/modules/survey/pages/pages.dart';
import 'package:easip_app/app/modules/survey/survey_controller.dart';
import 'package:easip_app/app/modules/survey/survey_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easip_app/app/modules/survey/pages/pages.dart';
import 'package:easip_app/app/modules/survey/survey_controller.dart';
import 'package:easip_app/app/modules/survey/survey_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarOwnershipPage extends StatelessWidget {
  const CarOwnershipPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SurveyController>();

    return Obx(
      () => BaseSurveyPage(
        controller: controller,
        currentStep: 7,
        totalSteps: 11,
        isNextEnabled: controller.hasCar.value != null,
        onNextPressed: () async {
          if (controller.hasCar.value == false) {
            // Skip the car asset page if user doesn't own a car
            await Future.delayed(Duration.zero); // Allow the UI to update
            controller.nextPage(); // Go to page 8 (car asset page)
            await Future.delayed(Duration.zero); // Allow the UI to update
            controller.nextPage(); // Skip to page 9 (marriage status page)
          } else {
            controller.nextPage(); // Normal next page to car asset page
          }
        },
        title: '자동차를 소유하고 계신가요?',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                '💬 차량 소유 여부는 자산 기준에 포함될 수 있어요.\n※ 본인 명의 또는 세대원의 차량도 포함됩니다.',
                style: SurveyAssets.bodyStyle.copyWith(
                  fontSize: 14,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),

            // Radio options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  RadioListTile<bool>(
                    title: Text(
                      '네',
                      style: SurveyAssets.bodyStyle.copyWith(fontSize: 16),
                    ),
                    value: true,
                    groupValue: controller.hasCar.value,
                    onChanged: (bool? value) {
                      if (value != null) {
                        controller.hasCar.value = value;
                      }
                      controller.update();
                    },
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  RadioListTile<bool>(
                    title: Text(
                      '아니요',
                      style: SurveyAssets.bodyStyle.copyWith(fontSize: 16),
                    ),
                    value: false,
                    groupValue: controller.hasCar.value,
                    onChanged: (bool? value) {
                      if (value != null) {
                        controller.hasCar.value = value;
                      }
                      controller.update();
                    },
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
