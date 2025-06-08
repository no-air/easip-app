import 'package:easip_app/app/modules/survey/survey_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../survey_assets.dart';
import '../survey_controller.dart';
import 'base_survey_page.dart';

class InterestAreasPage extends StatefulWidget {
  const InterestAreasPage({Key? key}) : super(key: key);

  @override
  State<InterestAreasPage> createState() => _InterestAreasPageState();
}

class _InterestAreasPageState extends State<InterestAreasPage> {
  final SurveyController controller = Get.find<SurveyController>();

  @override
  Widget build(BuildContext context) {
    // Split districts into two columns
    final halfLength = (SurveyAssets.districts.length / 2).ceil();
    final firstColumn = SurveyAssets.districts.sublist(0, halfLength);
    final secondColumn = SurveyAssets.districts.sublist(halfLength);

    return BaseSurveyPage(
      controller: controller,
      currentStep: 1,
      totalSteps: 11,
      title: '관심있는 청약 지역은 어디인가요?',
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
                                    child: Obx(
                                      () => Checkbox(
                                        value: controller.interestAreaIds
                                            .contains(firstColumn[index]['id']),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            controller.toggleInterestArea(
                                              firstColumn[index]['id']!
                                            );
                                          });
                                        },
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
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
                                    child: Obx(
                                      () => Checkbox(
                                        value: controller.interestAreaIds
                                            .contains(secondColumn[index]['id']),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            controller.toggleInterestArea(
                                              secondColumn[index]['id']!,
                                            );
                                          });
                                        },
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
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
        ],
      ),
      isNextEnabled: controller.interestAreaIds.isNotEmpty,
      onNextPressed: controller.nextPage,
    );
  }
}
