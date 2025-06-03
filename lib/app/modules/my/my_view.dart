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
              const Text(
                '붕어붕어금붕어',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'plMedium',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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
          label: '주택여부',
          options: const ['무주택', '주택보유'],
          currentValue: controller.hasHouse.value ? 1 : 0,
          onChanged: (value) => controller.updateHasHouse(value == 1),
          isEditMode: controller.isEditMode.value,
          getDisplayText: (value) => value == 1 ? '주택보유' : '무주택',
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

class PersonalInfoModel {
  final String name;
  final String dayOfBirth;
  final List<String> likingDistrictIds;
  final String livingDistrictId;
  final int myMonthlySalary;
  final int familyMemberMonthlySalary;
  final int allFamilyMemberCount;
  final String position;
  final bool hasCar;
  final int carPrice;
  final int assetPrice;

  PersonalInfoModel({
    required this.name,
    required this.dayOfBirth,
    required this.likingDistrictIds,
    required this.livingDistrictId,
    required this.myMonthlySalary,
    required this.familyMemberMonthlySalary,
    required this.allFamilyMemberCount,
    required this.position,
    required this.hasCar,
    required this.carPrice,
    required this.assetPrice,
  });

  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) {
    return PersonalInfoModel(
      name: json['name'] ?? '',
      dayOfBirth: json['dayOfBirth'] ?? '',
      likingDistrictIds: List<String>.from(json['likingDistrictIds'] ?? []),
      livingDistrictId: json['livingDistrictId'] ?? '',
      myMonthlySalary: json['myMonthlySalary'] ?? 0,
      familyMemberMonthlySalary: json['familyMemberMonthlySalary'] ?? 0,
      allFamilyMemberCount: json['allFamilyMemberCount'] ?? 0,
      position: json['position'] ?? '',
      hasCar: json['hasCar'] ?? false,
      carPrice: json['carPrice'] ?? 0,
      assetPrice: json['assetPrice'] ?? 0,
    );
  }
}