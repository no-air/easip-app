import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../survey_assets.dart';
import '../survey_controller.dart';
import 'base_survey_page.dart';

class LivingAreaPage extends StatefulWidget {
  const LivingAreaPage({Key? key}) : super(key: key);

  @override
  _LivingAreaPageState createState() => _LivingAreaPageState();
}

class _LivingAreaPageState extends State<LivingAreaPage> {
  final SurveyController controller = Get.find<SurveyController>();
  String? selectedDistrictId;
  
  // Use districts from SurveyAssets
  List<Map<String, String>> get districts => SurveyAssets.districts;

  @override
  void initState() {
    super.initState();
    // Initialize with the previously selected district if any
    if (controller.livingDistrictIds.isNotEmpty) {
      selectedDistrictId = controller.livingDistrictIds.first;
    }
  }

  @override
  void dispose() {
    // No need to dispose the controller as it's managed by GetX
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Split districts into two columns
    final halfLength = (districts.length / 2).ceil();
    final firstColumn = districts.sublist(0, halfLength);
    final secondColumn = districts.sublist(halfLength);

    return BaseSurveyPage(
      controller: controller,
      currentStep: 2,
      totalSteps: 11,
      title: '거주지는 어디인가요?',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First column
                      SizedBox(
                        width: 117,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            firstColumn.length,
                            (index) => SizedBox(
                              height: 40,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Radio<String>(
                                      value: firstColumn[index]['id']!,
                                      groupValue: selectedDistrictId,
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedDistrictId = value;
                                          controller.updateLivingDistrict(value ?? '');
                                        });
                                      },
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                  const SizedBox(width: 0),
                                  SizedBox(
                                    width: 77,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        firstColumn[index]['name']!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'PaperlogyMedium',
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 38),
                      // Second column
                      SizedBox(
                        width: 117,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            secondColumn.length,
                            (index) => SizedBox(
                              height: 40,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Radio<String>(
                                      value: secondColumn[index]['id']!,
                                      groupValue: selectedDistrictId,
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedDistrictId = value;
                                          controller.updateLivingDistrict(value ?? '');
                                        });
                                      },
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                  const SizedBox(width: 0),
                                  SizedBox(
                                    width: 77,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        secondColumn[index]['name']!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'PaperlogyMedium',
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
      isNextEnabled: selectedDistrictId != null,
      onNextPressed: controller.nextPage,
    );
  }
}
