import 'package:easip_app/app/modules/survey/survey_controller.dart';
import 'package:easip_app/app/modules/survey/survey_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'base_survey_page.dart';

class MarriageStatusPage extends StatefulWidget {
  const MarriageStatusPage({super.key});

  @override
  State<MarriageStatusPage> createState() => _MarriageStatusPageState();
}

class _MarriageStatusPageState extends State<MarriageStatusPage> {
  final SurveyController controller = Get.find<SurveyController>();

  @override
  Widget build(BuildContext context) {
    return BaseSurveyPage(
      currentStep: 7,
      totalSteps: 11,
      title: '혼인 여부를 알려주세요',
      controller: controller,
      isNextEnabled: controller.marriageStatus.value.isNotEmpty,
      onNextPressed: controller.nextPage,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              '💬 혼인 상태에 따라 신청 가능한 주거지원 제도가 달라질 수 있어요.',
              style: SurveyAssets.bodyStyle.copyWith(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 48),
            Obx(
              () => Column(
                children: [
                  RadioListTile<String>(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '네 이미 결혼했어요',
                          style: SurveyAssets.bodyStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '(혼인신고하고 기혼 7년 이하 포함)',
                          style: SurveyAssets.bodyStyle.copyWith(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    value: 'married',
                    groupValue: controller.marriageStatus.value,
                    onChanged: (String? value) {
                      if (value != null) {
                        controller.marriageStatus.value = value;
                        setState(
                          () {},
                        ); // Trigger rebuild to update button state
                      }
                    },
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  const SizedBox(height: 12),
                  RadioListTile<String>(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '네, 결혼 예정입니다.',
                          style: SurveyAssets.bodyStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '(예식장 예약자나 청약신청을 위한 사람)',
                          style: SurveyAssets.bodyStyle.copyWith(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    value: 'engaged',
                    groupValue: controller.marriageStatus.value,
                    onChanged: (String? value) {
                      if (value != null) {
                        controller.marriageStatus.value = value;
                        setState(
                          () {},
                        ); // Trigger rebuild to update button state
                      }
                    },
                    contentPadding: EdgeInsets.zero,
                    visualDensity: const VisualDensity(vertical: 3),
                  ),
                  RadioListTile<String>(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '아니요, 아직 결혼 계획 없어요',
                          style: SurveyAssets.bodyStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    value: 'single',
                    groupValue: controller.marriageStatus.value,
                    onChanged: (String? value) {
                      if (value != null) {
                        controller.marriageStatus.value = value;
                        setState(
                          () {},
                        ); // Trigger rebuild to update button state
                      }
                    },
                    contentPadding: EdgeInsets.zero,
                    visualDensity: const VisualDensity(vertical: 3),
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
