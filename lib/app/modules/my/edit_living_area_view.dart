import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_controller.dart';

class EditLivingAreaView extends GetView<MyController> {
  const EditLivingAreaView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<MyController>(
      builder: (controller) => _buildLivingAreaPage(controller),
    );
  }

  Widget _buildLivingAreaPage(MyController controller) {
    final List<String> options = [
      ...controller.districts.value?.names ?? [],
      EditAssets.etc,
    ];
    // Split options into two columns
    final halfLength = (options.length / 2).ceil();
    final firstColumn = options.sublist(0, halfLength);
    final secondColumn = options.sublist(halfLength);

    // livingArea 초기값 세팅: userProfile.livingDistrictId와 일치하는 index
    if (controller.livingArea.value == null &&
        controller.userProfile.value?.livingDistrictId != null) {
      final idx = options.indexOf(
        controller.userProfile.value!.livingDistrictId,
      );
      if (idx != -1) {
        controller.livingArea.value = idx;
      }
    }

    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 24),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 51,
            ), // X position 51px
            child: Text(
              '거주지는 어디인가요?',
              style: EditAssets.headingStyle.copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
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
                                  width: 40, // 40x40 radio button
                                  height: 40,
                                  child: Radio<int>(
                                    value: index,
                                    groupValue: controller.livingArea.value,
                                    onChanged: (int? value) {
                                      if (value != null) {
                                        controller.livingArea.value = value;
                                      }
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
                                  width: 40, // 40x40 radio button
                                  height: 40,
                                  child: Radio<int>(
                                    value: index + halfLength,
                                    groupValue: controller.livingArea.value,
                                    onChanged: (int? value) {
                                      if (value != null) {
                                        controller.livingArea.value = value;
                                      }
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
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'PaperlogyMedium',
              ),
              child: Edit_Save_BottomButton(
                onPressed: () {
                  final selectedIndex = controller.livingArea.value;
                  final selectedValue =
                      selectedIndex != null ? options[selectedIndex] : null;
                  if (selectedValue != null &&
                      controller.userProfile.value != null) {
                    controller.userProfile.value = controller.userProfile.value!
                        .copyWith(livingDistrictId: selectedValue);
                  }
                  Get.back();
                },
                text: '저장',
                enabled: controller.livingArea.value != null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Edit_Save_BottomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool enabled;

  const Edit_Save_BottomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: enabled ? Colors.black : Colors.grey[400],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'plMedium',
            ),
          ),
        ),
      ),
    );
  }
}

class EditAssets {
  static const String etc = '그 외';

  // Typography
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: 'plMedium', // Using your existing font family
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    fontFamily: 'plLight',
  );
}
