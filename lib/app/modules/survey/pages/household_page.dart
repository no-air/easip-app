import 'package:easip_app/app/modules/survey/survey_assets.dart';
import 'package:easip_app/app/modules/survey/survey_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../survey_controller.dart';
import 'base_survey_page.dart';

// household_page.dart
class HouseholdPage extends StatelessWidget {
  const HouseholdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SurveyController controller = Get.find<SurveyController>();

    final TextEditingController familyCountController = TextEditingController(
      text:
          controller.householdSize > 0
              ? controller.householdSize.toString()
              : '',
    );

    return BaseSurveyPage(
      currentStep: 4,
      totalSteps: 11,
      title: '함께 살고 있는 가족 수는 \n 몇명인가요?',
      controller: controller,
      isNextEnabled: controller.householdSize >= 0,
      onNextPressed: () {
        if (controller.householdSize.value == 0) {
          // Skip to page 7 (index 6) if household size is 0
          controller.currentPage.value = 6;
        } else {
          controller.nextPage();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: familyCountController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      hintText: '0',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (value) {
                      final count = int.tryParse(value) ?? 0;
                      controller.householdSize.value = count;

                      // Initialize or update family salaries list
                      if (count >= 0) {
                        if (controller.familySalaries.length != count) {
                          controller.familySalaries.value = List<int>.filled(
                            count,
                            0,
                          );
                        }
                        
                        // Update the text field with parsed value
                        final newText = count == 0 ? '' : count.toString();
                        if (familyCountController.text != newText) {
                          familyCountController.text = newText;
                          familyCountController.selection = TextSelection.collapsed(
                            offset: newText.length,
                          );
                        }
                        
                        // Update the next button state
                        controller.update();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '명',
                  style: SurveyAssets.headingStyle.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
