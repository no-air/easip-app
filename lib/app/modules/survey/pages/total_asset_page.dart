import 'package:easip_app/app/modules/survey/pages/pages.dart';
import 'package:easip_app/app/modules/survey/widgets/salary_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../survey_assets.dart';
import '../survey_controller.dart';

class TotalAssetPage extends StatefulWidget {
  const TotalAssetPage({Key? key}) : super(key: key);

  @override
  _TotalAssetPageState createState() => _TotalAssetPageState();
}

class _TotalAssetPageState extends State<TotalAssetPage> {
  late final TextEditingController _totalAssetsController;
  final SurveyController controller = Get.find<SurveyController>();

  @override
  void initState() {
    super.initState();
    _totalAssetsController = TextEditingController(
      text:
          controller.totalAssets.value > 0
              ? controller.totalAssets.value.toString()
              : '',
    );
    _totalAssetsController.addListener(_updateTotalAssets);
  }

  void _updateTotalAssets() {
    final digits = _totalAssetsController.text.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );
    final amount = int.tryParse(digits) ?? 0;
    controller.totalAssets.value = amount;
  }

  @override
  void dispose() {
    _totalAssetsController.removeListener(_updateTotalAssets);
    _totalAssetsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseSurveyPage(
      controller: controller,
      currentStep: 9,
      totalSteps: 11,
      title: '총 자산가액을 입력해주세요.',
      isNextEnabled: _totalAssetsController.text.trim().isNotEmpty,
      onNextPressed: () {
        _updateTotalAssets();
        controller.nextPage();
        print("totalAssets: ${controller.totalAssets.value}");
      },
      showSkipButton: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  Text(
                    '💬 총 자산은 본인과 가족이 보유한 자산을 모두 합한 금액이에요.\n대략적인 금액으로 입력하셔도 괜찮아요!\n\n 총 자산 = 부동산 + 자동차 + 금융자산(예금 등) + 일반자산 – 부채',
                    style: SurveyAssets.bodyStyle.copyWith(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SalaryInputField(
              hintText: '1,000',
              controller: _totalAssetsController,
              onChanged: (value) {
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
