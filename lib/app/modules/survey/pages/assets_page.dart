import 'package:easip_app/app/modules/survey/pages/pages.dart';
import 'package:easip_app/app/modules/survey/widgets/salary_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../survey_assets.dart';
import '../survey_controller.dart';

// Page 4 : 현재 월급
class AssetsPage extends StatefulWidget {
  const AssetsPage({Key? key}) : super(key: key);

  @override
  _AssetsPageState createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  late final TextEditingController _assetsController;

  @override
  void initState() {
    super.initState();
    _assetsController = TextEditingController(
      text: Get.find<SurveyController>().income.value.toString(),
    );
  }

  @override
  void dispose() {
    _assetsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SurveyController>();

    return BaseSurveyPage(
      controller: controller,
      currentStep: 3,
      totalSteps: 11,
      title: '현재 월급은 얼마인가요?',
      showSkipButton: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subtitle with link
            GestureDetector(
              onTap: () async {
                final url = Uri.parse(
                  'https://www.nhis.or.kr/nhis/minwon/minwonServiceBoard.do?mode=view&articleNo=10945799',
                );
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    SurveyAssets.depositHeartSvg,
                    width: 9,
                    height: 8,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '지난 달 나의 보수월액 바로 확인하기',
                    style: SurveyAssets.bodyStyle.copyWith(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Asset input field
            const SizedBox(height: 24),
            SalaryInputField(
              hintText: '1,000',
              controller: _assetsController,
              onChanged: (value) {
                controller.income.value = int.parse(value);
                controller.update();
              },
            ),
          ],
        ),
      ),
      isNextEnabled: controller.income.value >= 0,
      onNextPressed: controller.nextPage,
    );
  }
}
