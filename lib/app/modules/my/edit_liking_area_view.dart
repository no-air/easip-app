import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_controller.dart';
import 'edit_living_area_view.dart';

class EditLikingAreaView extends GetView<MyController> {
  const EditLikingAreaView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<MyController>(
      builder: (controller) => _buildLikingAreaPage(controller),
    );
  }

  Widget _buildLikingAreaPage(MyController controller) {
    if (controller.districts.value == null) {
      return Center(child: CircularProgressIndicator());
    }

    // Split districts into two columns
    final halfLength = (controller.districts.value!.names.length / 2).ceil();
    final firstColumn = controller.districts.value!.names.sublist(
      0,
      halfLength,
    );
    final secondColumn = controller.districts.value!.names.sublist(halfLength);

    if (controller.districts.value != null &&
        controller.likingAreas.length != controller.districts.value!.length) {
      final selected = controller.userProfile.value?.likingDistrictIds ?? [];
      controller.likingAreas.value = List.generate(
        controller.districts.value!.length,
        (i) => selected.contains(controller.districts.value!.names[i]),
      );
    }

    int selectedCount = controller.likingAreas.where((v) => v).length;

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 51, vertical: 10),
            child: Text(
              '관심있는 청약 지역은 어디인가요?',
              style: EditAssets.headingStyle.copyWith(fontSize: 24),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 51, right: 51),
            child: Text(
              '최대 3개까지 선택할 수 있습니다.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          const SizedBox(height: 16),
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
                        width: 117, // Fixed width for text frame
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            firstColumn.length,
                            (index) => SizedBox(
                              height: 40, // Fixed height for each row
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 40, // 40x40 checkbox
                                    height: 40,
                                    child: Checkbox(
                                      value: controller.likingAreas[index],
                                      onChanged: (bool? value) {
                                        final isChecked =
                                            controller.likingAreas[index];
                                        if (value == true &&
                                            selectedCount >= 3 &&
                                            !isChecked) {
                                          // 최대 3개 제한
                                          return;
                                        }
                                        controller.likingAreas[index] =
                                            value ?? false;
                                      },
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 77, // Remaining width for text
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        firstColumn[index],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'plMedium',
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
                      const SizedBox(width: 38), // 38px between columns
                      // Second column
                      SizedBox(
                        width: 117, // Fixed width for text frame
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            secondColumn.length,
                            (index) => SizedBox(
                              height: 40, // Fixed height for each row
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 40, // 40x40 checkbox
                                    height: 40,
                                    child: Checkbox(
                                      value:
                                          controller.likingAreas[index +
                                              halfLength],
                                      onChanged: (bool? value) {
                                        final isChecked =
                                            controller.likingAreas[index +
                                                halfLength];
                                        if (value == true &&
                                            selectedCount >= 3 &&
                                            !isChecked) {
                                          return;
                                        }
                                        controller.likingAreas[index +
                                                halfLength] =
                                            value ?? false;
                                      },
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 77, // Remaining width for text
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        secondColumn[index],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'plMedium',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: DefaultTextStyle(
              style: const TextStyle(fontSize: 16, fontFamily: 'plMedium'),
              child: Edit_Save_BottomButton(
                onPressed: () {
                  controller.updateLikingDistrict();
                  Get.back();
                },
                text: '저장',
                enabled: controller.likingAreas.any((v) => v),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
