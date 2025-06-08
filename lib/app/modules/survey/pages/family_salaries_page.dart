import 'package:easip_app/app/modules/survey/survey_controller.dart';
import 'package:easip_app/app/modules/survey/survey_assets.dart';
import 'package:easip_app/app/modules/survey/widgets/salary_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'base_survey_page.dart';

class FamilySalariesPage extends StatefulWidget {
  const FamilySalariesPage({Key? key}) : super(key: key);

  @override
  State<FamilySalariesPage> createState() => _FamilySalariesPageState();
}

class _FamilySalariesPageState extends State<FamilySalariesPage> {
  final SurveyController controller = Get.find<SurveyController>();
  late final List<TextEditingController> _salaryControllers = [];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    // Clear existing controllers
    for (var c in _salaryControllers) {
      c.dispose();
    }
    _salaryControllers.clear();

    // Initialize with existing values
    if (controller.familySalaries.isEmpty &&
        controller.householdSize.value > 0) {
      controller.familySalaries.value = List.filled(
        controller.householdSize.value,
        0,
      );
    }

    // Create controllers with existing values
    for (var i = 0; i < controller.householdSize.value; i++) {
      final controller = TextEditingController();
      if (i < this.controller.familySalaries.length &&
          this.controller.familySalaries[i] > 0) {
        controller.text = (this.controller.familySalaries[i]).toString();
      }
      _salaryControllers.add(controller);
    }
  }

  @override
  void dispose() {
    for (var c in _salaryControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseSurveyPage(
      currentStep: 5,
      totalSteps: 11,
      title: '가족 구성원의 보수 월액을\n입력해주세요(자신 제외)',
      controller: controller,
      showBackButton: true,
      showSkipButton: true,
      onNextPressed: () {
        // Save all values before proceeding
        for (var i = 0; i < _salaryControllers.length; i++) {
          final value =
              int.tryParse(
                _salaryControllers[i].text.replaceAll(RegExp(r'[^0-9]'), ''),
              ) ??
              0;
          controller.familySalaries[i] = value;
        }
        controller.nextPage();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              '학생, 주부, 무직 등 소득이 없을 경우 0을 입력해주세요',
              style: SurveyAssets.bodyStyle.copyWith(
                fontSize: 14,
                color: Colors.grey[500],
                fontFamily: 'PaperlogMedium',
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _launchSalaryInquiry,
              child: Row(
                children: [
                  SvgPicture.asset(
                    SurveyAssets.depositHeartSvg,
                    width: 8,
                    height: 8,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '지난 달 나의 보수월액 바로 확인하기',
                    style: SurveyAssets.bodyStyle.copyWith(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Obx(() {
                if (_salaryControllers.length !=
                    controller.householdSize.value) {
                  _initializeControllers();
                }
                return ListView.builder(
                  itemCount: controller.householdSize.value,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SalaryInputField(
                        hintText: '1,000',
                        controller: _salaryControllers[index],
                        onChanged: (value) {
                          controller.familySalaries[index] = int.parse(value);
                          controller.update();
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      isNextEnabled: _salaryControllers.any((c) => c.text.trim().isNotEmpty),
    );
  }

  Future<void> _launchSalaryInquiry() async {
    final url = Uri.parse(
      'https://www.nhis.or.kr/nhis/minwon/minwonServiceBoard.do?mode=view&articleNo=10945799',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}
