import 'package:easip_app/app/core/widgets/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_controller.dart';
import 'my_info_row.dart';

class MyView extends GetView<MyController> {
  const MyView({super.key});

  static const _buttonStyle = TextStyle(
    fontFamily: 'plMedium',
    color: Colors.black,
    fontSize: 12,
  );

  static const _privacyButtonStyle = TextStyle(
    fontFamily: 'plMedium',
    color: Colors.black,
    fontSize: 13,
  );

  static final _textButtonStyle = TextButton.styleFrom(
    padding: EdgeInsets.zero,
    minimumSize: Size.zero,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );

  @override
  Widget build(BuildContext context) {
    return GetX<MyController>(
      builder: (controller) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const SizedBox(height: 64),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: controller.canEdit.value 
                      ? (controller.isEditMode.value ? controller.saveChanges : controller.toggleEditMode)
                      : null,
                    style: _textButtonStyle,
                    child: Text(
                      controller.isEditMode.value ? '저장' : '수정하기',
                      style: TextStyle(
                        color: controller.canEdit.value 
                          ? (controller.isEditMode.value ? Colors.blue : Colors.grey)
                          : Colors.grey.withOpacity(0.5),
                        fontSize: 14,
                        fontWeight: controller.isEditMode.value ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GetX<MyController>(
                builder: (controller) => Column(
                  children: [
                    if (controller.isEditMode.value)
                      SizedBox(
                        child: TextField(
                          controller: controller.nameController,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'plMedium',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      )
                    else
                      Text(
                        controller.personalInfo.value?.name ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'plMedium',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              _buildInterestedSection(),
              const SizedBox(height: 30),
              _buildMyInfoSection(controller),
              const SizedBox(height: 40),
              _buildBottomButtons(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInterestedSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '관심 공고',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              const Text(
                '20개',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              ImageAsset(imagePath:'assets/icon/subtract.svg', width: 18, height: 18),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMyInfoSection(MyController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            '내정보',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Divider(height: 1, thickness: 1, color: Colors.grey[300]!),
        const SizedBox(height: 10),
        MyInfoRow(
          label: '생년월일',
          controller: controller.dayOfBirthController,
          inputType: TextInputType.datetime,
          isEditMode: controller.isEditMode.value,
          formatValue: (value) => controller.formatDate(value),
        ),
        MyChipRow(
          label: '선호지역',
          values: controller.getDistrictNames(null),
        ),
        MyChipRow(
          label: '거주지역',
          values: [controller.getDistrictName(null)],
        ),
        MyToggleRow(
          label: '전형',
          options: const ['신혼부부', '청년'],
          currentValue: controller.selectedPosition.value ? 1 : 0,
          onChanged: (value) => controller.updatePosition(value == 1),
          isEditMode: controller.isEditMode.value,
          getDisplayText: (value) => value == 1 ? '신혼부부' : '청년',
        ),
        MyInfoRow(
          label: '월소득',
          controller: controller.mySalaryController,
          inputType: TextInputType.number,
          isEditMode: controller.isEditMode.value,
          formatValue: (value) => controller.formatPrice(int.tryParse(value)),
        ),
        MyInfoRow(
          label: '가족 월소득',
          controller: controller.familySalaryController,
          inputType: TextInputType.number,
          isEditMode: controller.isEditMode.value,
          formatValue: (value) => controller.formatPrice(int.tryParse(value)),
        ),
        MyInfoRow(
          label: '세대원 수',
          controller: controller.familyCountController,
          inputType: TextInputType.number,
          isEditMode: controller.isEditMode.value,
          formatValue: (value) => value,
        ),
        MyInfoRow(
          label: '자동차가액',
          controller: controller.carPriceController,
          inputType: TextInputType.number,
          isEditMode: controller.isEditMode.value,
          formatValue: (value) => controller.formatPrice(int.tryParse(value)),
        ),
        MyInfoRow(
          label: '재산가액',
          controller: controller.assetPriceController,
          inputType: TextInputType.number,
          isEditMode: controller.isEditMode.value,
          formatValue: (value) => controller.formatPrice(int.tryParse(value)),
        ),
        
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () {},
          style: _textButtonStyle,
          child: const Text('개인 정보 약관 조회', style: _privacyButtonStyle),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              style: _textButtonStyle,
              child: const Text('로그아웃', style: _buttonStyle),
            ),
            const SizedBox(width: 24),
            TextButton(
              onPressed: () {},
              style: _textButtonStyle,
              child: const Text('회원탈퇴', style: _buttonStyle),
            ),
          ],
        ),
      ],
    );
  }
}