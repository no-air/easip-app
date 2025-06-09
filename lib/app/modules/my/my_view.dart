import 'package:easip_app/app/core/widgets/image_asset.dart';
import 'package:easip_app/app/modules/onboarding/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_controller.dart';
import 'my_info_row.dart';
import '../../components//app/custom_alert.dart';
import '../..//routes/app_routes.dart';
import 'edit_living_area_view.dart';
import 'edit_liking_area_view.dart';

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
                    onPressed: () {
                      if (controller.districts.value == null) {
                        controller.getDistrictList();
                      }
                      if (controller.canEdit.value) {
                        if (controller.isEditMode.value) {
                          controller.saveChanges();
                        } else {
                          controller.toggleEditMode();
                        }
                      }
                    },
                    style: _textButtonStyle,
                    child: Text(
                      controller.isEditMode.value ? '저장' : '수정하기',
                      style: TextStyle(
                        color:
                            controller.canEdit.value
                                ? (controller.isEditMode.value
                                    ? Colors.blue
                                    : Colors.grey)
                                : Colors.grey.withOpacity(0.5),
                        fontSize: 14,
                        fontWeight:
                            controller.isEditMode.value
                                ? FontWeight.w600
                                : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              GetX<MyController>(
                builder:
                    (controller) => Column(
                      children: [
                        if (controller.isEditMode.value)
                          Container(
                            alignment: Alignment.center,
                            child: TextField(
                              controller: controller.nameController,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'plMedium',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                isCollapsed: true,
                              ),
                            ),
                          )
                        else
                          Text(
                            controller.nameController.text,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'plMedium',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
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
    return GestureDetector(
      onTap: () => Get.toNamed('/alarm-registered'),
      child: Container(
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
                Text(
                  '${controller.userProfile.value?.likingPostCount ?? 0}개',
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                ImageAsset(
                  imagePath: 'assets/icon/subtract.svg',
                  width: 18,
                  height: 18,
                ),
              ],
            ),
          ],
        ),
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
        GetX<MyController>(
          builder:
              (controller) => Column(
                children: [
                  MyInfoRow(
                    label: '생년월일',
                    controller: controller.dayOfBirthController,
                    inputType: TextInputType.datetime,
                    isEditMode: controller.isEditMode.value,
                    formatValue: (value) => controller.formatDate(value),
                    type: MyInfoRowType.none,
                  ),
                  MyChipRow(
                    label: '거주지역',
                    values: [
                      controller.userProfile.value?.livingDistrictId ?? '',
                    ],
                    onTap:
                        controller.isEditMode.value
                            ? () {
                              showModalBottomSheet(
                                context: Get.context!,
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                useSafeArea: true,
                                builder: (context) => Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: FractionallySizedBox(
                                    heightFactor: 0.8,
                                    child: const EditLivingAreaView(),
                                  ),
                                ),
                              );
                            }
                            : null,
                  ),
                  MyChipRow(
                    label: '선호지역',
                    values:
                        controller.userProfile.value?.likingDistrictIds ?? [],
                    onTap:
                        controller.isEditMode.value
                            ? () {
                              showModalBottomSheet(
                                context: Get.context!,
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                useSafeArea: true,
                                builder: (context) => Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: FractionallySizedBox(
                                    heightFactor: 0.8,
                                    child: const EditLikingAreaView(),
                                  ),
                                ),
                              );
                            }
                            : null,
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
                    formatValue: (value) => value,
                    type: MyInfoRowType.money,
                  ),
                  MyInfoRow(
                    label: '가족 월소득',
                    controller: controller.familySalaryController,
                    inputType: TextInputType.number,
                    isEditMode: controller.isEditMode.value,
                    formatValue: (value) => value,
                    type: MyInfoRowType.money,
                  ),
                  MyInfoRow(
                    label: '세대원 수',
                    controller: controller.familyCountController,
                    inputType: TextInputType.number,
                    isEditMode: controller.isEditMode.value,
                    formatValue: (value) => value,
                    type: MyInfoRowType.headCount,
                  ),
                  MyInfoRow(
                    label: '자동차가액',
                    controller: controller.carPriceController,
                    inputType: TextInputType.number,
                    isEditMode: controller.isEditMode.value,
                    formatValue: (value) => value,
                    type: MyInfoRowType.money,
                  ),
                  MyInfoRow(
                    label: '재산가액',
                    controller: controller.assetPriceController,
                    inputType: TextInputType.number,
                    isEditMode: controller.isEditMode.value,
                    formatValue: (value) => value,
                    type: MyInfoRowType.money,
                  ),
                ],
              ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Builder(
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () async {
                  await controller.redirectToPrivacyTerms();
                },
                style: _textButtonStyle,
                child: const Text('개인 정보 약관 조회', style: _privacyButtonStyle),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.find<SignInController>().performSignOut();
                      Get.offAllNamed(Routes.onboarding);
                    },
                    style: _textButtonStyle,
                    child: const Text('로그아웃', style: _buttonStyle),
                  ),
                  const SizedBox(width: 24),
                  TextButton(
                    onPressed: () {
                      CustomAlert.show(
                        context,
                        title: _buildWithdrawalDialogTitle(context),
                        content: '짧은 기간 내 탈퇴와 재가입이 반복되면\n서비스 이용이 어려울 수 있어요.',
                        confirmText: '확인',
                        cancelText: '취소',
                        onConfirm: () async {
                          try {
                            await controller.deleteAccount();
                            if (controller.isDeleted.value) {
                              await Get.find<SignInController>()
                                  .performSignOut();
                              Get.offAllNamed(Routes.onboarding);
                            }
                          } catch (e) {
                            Get.snackbar(
                              '회원탈퇴 실패',
                              '회원탈퇴 중 오류가 발생했습니다. 다시 시도해주세요.',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                        onCancel: () {},
                      );
                    },
                    style: _textButtonStyle,
                    child: const Text('회원탈퇴', style: _buttonStyle),
                  ),
                ],
              ),
            ],
          ),
    );
  }

  Widget _buildWithdrawalDialogTitle(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: [
          const TextSpan(text: '정말 '),
          TextSpan(
            text: '이 집',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(text: '을 탈퇴할까요?'),
        ],
      ),
    );
  }
}
