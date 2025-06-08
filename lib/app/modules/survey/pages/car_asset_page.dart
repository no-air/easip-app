import 'package:easip_app/app/modules/survey/pages/pages.dart';
import 'package:easip_app/app/modules/survey/survey_controller.dart';
import 'package:easip_app/app/modules/survey/survey_assets.dart';
import 'package:easip_app/app/modules/survey/widgets/salary_input_field.dart';
import 'package:easip_app/app/modules/survey/widgets/progress_dots.dart';
import 'package:easip_app/app/modules/survey/widgets/survey_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class CarAssetPage extends StatefulWidget {
  const CarAssetPage({super.key});

  @override
  State<CarAssetPage> createState() => _CarAssetPageState();
}

class _CarAssetPageState extends State<CarAssetPage> {
  final SurveyController controller = Get.find<SurveyController>();
  late final TextEditingController _carValueController;

  @override
  void initState() {
    super.initState();
    _carValueController = TextEditingController();
    // Initialize with existing value if any
    if (controller.carAsset.value != 0) {
      _carValueController.text = (controller.carAsset.value).toString();
    }
  }

  @override
  void dispose() {
    _carValueController.dispose();
    super.dispose();
  }

  Future<void> _launchCarValueInquiry() async {
    final url = Uri.parse('https://www.kidi.or.kr/user/car/carprice.do');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseSurveyPage(
      controller: controller,
      currentStep: 8,
      totalSteps: 11,
      title: '차량 가액을 입력해주세요',
      showBackButton: true,
      showSkipButton: true,
      isNextEnabled: _carValueController.text.trim().isNotEmpty,
      onNextPressed: () {
        if (_carValueController.text.trim().isNotEmpty) {
          final value =
              int.tryParse(
                _carValueController.text.replaceAll(RegExp(r'[^0-9]'), ''),
              ) ??
              0;
          controller.carAsset.value = value;
          controller.nextPage();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            GestureDetector(
              onTap: _launchCarValueInquiry,
              child: Row(
                children: [
                  SvgPicture.asset(
                    SurveyAssets.carAssetSvg,
                    width: 8,
                    height: 8,
                  ),
                  const SizedBox(width: 8),
                  Text('차량 가액 조회하기', style: SurveyAssets.bodyStyle),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SalaryInputField(
              hintText: '1,000',
              controller: _carValueController,
              onChanged: (value) {
                setState(() {}); // Trigger rebuild for next button state
              },
            ),
          ],
        ),
      ),
    );
  }
}
