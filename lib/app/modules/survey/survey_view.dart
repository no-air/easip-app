import 'package:easip_app/app/modules/survey/birth_date_page.dart';
import 'package:easip_app/app/modules/survey/survey_common.dart';
import 'package:easip_app/app/modules/survey/widgets/salary_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'survey_controller.dart';
import 'survey_assets.dart';

class SurveyView extends GetView<SurveyController> {
  const SurveyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return GestureDetector(
            onHorizontalDragEnd: (details) {
              // Check if the swipe is from right to left (positive velocity)
              if (details.primaryVelocity! > 0) {
                // Navigate to previous page if not on the first page
                if (controller.currentPage.value > 0) {
                  controller.previousPage();
                }
              }
            },
            child: _buildPage(controller.currentPage.value),
          );
        }),
      ),
    );
  }

  Widget _buildPage(int page) {
    switch (page) {
      case 0:
        return _buildBirthDatePage(); // 생년월일 입력
      case 1:
        return _buildInterestAreasPage(); // 관심있는 청약 지역
      case 2:
        return _buildLivingAreaPage(); // 거주지
      case 3:
        return _buildSalaryPage(); // 월급
      case 4:
        return _buildFamilyCountPage(); // 가족 수
      case 5:
        return _buildFamilySalariesPage(); // 가족 구성원 보수월액
      case 6:
        return _buildMarriageStatusPage(); // 혼인 여부
      case 7:
        return _buildCarOwnershipPage(); // 자동차 소유 여부
      case 8:
        return _buildMyAssetPage(); // 자산 가치
      case 9:
        return _buildTotalAssetPage(); // 총 자산 가치
      case 10:
        return _buildCompletionPage(); // 완료 페이지
      default:
        return _buildDefaultPage();
    }
  }

  // 1번 페이지 : 생년 월일 입력
  Widget _buildBirthDatePage() {
    return BirthDatePage(controller: controller);
  }

  // 2번 페이지 : 관심있는 청약 지역
  Widget _buildInterestAreasPage() {
    // Split districts into two columns
    final halfLength = (SurveyAssets.districts.length / 2).ceil();
    final firstColumn = SurveyAssets.districts.sublist(0, halfLength);
    final secondColumn = SurveyAssets.districts.sublist(halfLength);

    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 51), // X position 51px
            child: ProgressDots(total: 11, current: 1),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 51,
            ), // X position 51px
            child: Text(
              '관심있는 청약 지역은 어디인가요?',
              style: SurveyAssets.headingStyle.copyWith(fontSize: 20),
              textAlign: TextAlign.left,
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
                                  width: 40, // 40x40 checkbox
                                  height: 40,
                                  child: Checkbox(
                                    value: controller.interestAreas[index],
                                    onChanged: (bool? value) {
                                      controller.interestAreas[index] =
                                          value ?? false;
                                      controller.interestAreas.refresh();
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
                                        controller.interestAreas[index +
                                            halfLength],
                                    onChanged: (bool? value) {
                                      controller.interestAreas[index +
                                              halfLength] =
                                          value ?? false;
                                      controller.interestAreas.refresh();
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
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'PaperlogyMedium',
              ),
              child: SurveyButton(
                text: '다음',
                onTap: controller.nextPage,
                enabled: controller.interestAreas.any((v) => v),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 3번 페이지 : 거주지
  Widget _buildLivingAreaPage() {
    final List<String> options = [...SurveyAssets.districts, SurveyAssets.etc];
    // Split options into two columns
    final halfLength = (options.length / 2).ceil();
    final firstColumn = options.sublist(0, halfLength);
    final secondColumn = options.sublist(halfLength);

    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 51), // X position 51px
            child: ProgressDots(total: 11, current: 2),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 51,
            ), // X position 51px
            child: Text(
              '거주지는 어디인가요?',
              style: SurveyAssets.headingStyle.copyWith(fontSize: 24),
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
                                    groupValue: controller.livingArea?.value,
                                    onChanged: (int? value) {
                                      if (value != null) {
                                        controller.livingArea?.value = value;
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
                                    groupValue: controller.livingArea?.value,
                                    onChanged: (int? value) {
                                      if (value != null) {
                                        controller.livingArea?.value = value;
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
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'PaperlogyMedium',
              ),
              child: SurveyButton(
                text: '다음',
                onTap: controller.nextPage,
                enabled: controller.livingArea != null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 4번 페이지 : 월급
  Widget _buildSalaryPage() {
    final salaryController = TextEditingController(
      text: controller.salary.value,
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 16,
            bottom: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ProgressDots(total: 11, current: 3),
                  TextButton(
                    onPressed: controller.nextPage,
                    child: const Text(
                      '건너뛰기',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '현재 월급은 얼마인가요?',
                style: SurveyAssets.headingStyle.copyWith(fontSize: 24),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  final Uri url = Uri.parse(
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
              const SizedBox(height: 16),
              SalaryInputField(
                hintText: '1,000',
                controller: salaryController,
                onChanged: (value) {
                  controller.salary.value = value;
                },
              ),
              const Spacer(),
              Obx(
                () => SurveyButton(
                  text: '다음',
                  onTap: controller.nextPage,
                  enabled: controller.salary.value.isNotEmpty,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 5번 페이지 : 가족 수
  Widget _buildFamilyCountPage() {
    final familyCountController = TextEditingController(
      text: controller.familyCount.value.toString(),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProgressDots(total: 11, current: 4),
          const SizedBox(height: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '주민등록등본 기준',
                style: SurveyAssets.headingStyle.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Text(
                '함께 살고 있는 가족 수는',
                style: SurveyAssets.headingStyle.copyWith(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              Text(
                '몇명인가요?',
                style: SurveyAssets.headingStyle.copyWith(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 100,
                child: SurveyTextField(
                  hint: '0',
                  controller: familyCountController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (v) {
                    int count = int.tryParse(v) ?? 0;
                    controller.familyCount.value = count;

                    // Initialize family salaries list with empty strings
                    if (count > 0 &&
                        controller.familySalaries.length != count) {
                      controller.familySalaries.value = List<String>.filled(
                        count,
                        '',
                      );
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '명',
                style: SurveyAssets.headingStyle.copyWith(fontSize: 28),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SurveyButton(
            text: '다음',
            onTap: controller.nextPage,
            enabled: controller.familyCount.value > 0,
          ),
        ],
      ),
    );
  }

  // 6번 페이지 : 가족 구성원 보수월액
  Widget _buildFamilySalariesPage() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 75, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProgressDots(total: 11, current: 5),
          const SizedBox(height: 12),
          Text(
            '가족 구성원의 보수월액을 입력해주세요',
            style: SurveyAssets.headingStyle.copyWith(fontSize: 24),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () async {
              final Uri url = Uri.parse(
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
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: controller.familyCount.value,
              itemBuilder: (context, index) {
                final salaryController = TextEditingController();
                final currentValue = controller.familySalaries[index];
                if (currentValue.isNotEmpty) {
                  final number = int.tryParse(currentValue) ?? 0;
                  if (number > 0) {
                    salaryController.text =
                        '${NumberFormat('#,###', 'ko_KR').format(number)}';
                  }
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SalaryInputField(
                          controller: salaryController,
                          hintText: '1,000',
                          onChanged: (value) {
                            controller.familySalaries[index] = value;
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          SurveyButton(
            text: '다음',
            onTap: controller.nextPage,
            enabled: controller.familySalaries.every(
              (salary) => salary.isNotEmpty && salary != '0',
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => controller.nextPage(),
            child: Text('나중에 입력하기', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  // 7번 페이지 : 혼인 여부
  Widget _buildMarriageStatusPage() {
    return Padding(
      padding: const EdgeInsets.only(left: 47, top: 75, right: 24, bottom: 40),
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ProgressDots(total: 11, current: 6),
              const SizedBox(height: 32),
              Text(
                '혼인 여부를 알려주세요',
                style: SurveyAssets.headingStyle.copyWith(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '혼인 상태에 따라 신청 가능한 주거지원 제도가 달라질 수 있어요.',
                style: SurveyAssets.bodyStyle.copyWith(fontSize: 10),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 16),
              Obx(
                () => Column(
                  children: [
                    RadioListTile<String>(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '네 이미 결혼했어요',
                            style: SurveyAssets.bodyStyle.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '(혼인신고하고 기혼 7년 이하 포함)',
                            style: SurveyAssets.bodyStyle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      value: 'married',
                      groupValue: controller.maritalStatus.value,
                      onChanged: (String? value) {
                        if (value != null) {
                          controller.maritalStatus.value = value;
                        }
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    RadioListTile<String>(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '네, 결혼 예정입니다.',
                            style: SurveyAssets.bodyStyle.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '(예식장 예약자나 청약신청을 위한 사람)',
                            style: SurveyAssets.bodyStyle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      value: 'engaged',
                      groupValue: controller.maritalStatus.value,
                      onChanged: (String? value) {
                        if (value != null) {
                          controller.maritalStatus.value = value;
                        }
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    RadioListTile<String>(
                      title: Text(
                        '아니요, 미혼이에요',
                        style: SurveyAssets.bodyStyle.copyWith(fontSize: 20),
                      ),
                      value: 'single',
                      groupValue: controller.maritalStatus.value,
                      onChanged: (String? value) {
                        if (value != null) {
                          controller.maritalStatus.value = value;
                        }
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Obx(
            () => SurveyButton(
              text: '다음',
              onTap:
                  controller.maritalStatus.value.isNotEmpty
                      ? controller.nextPage
                      : null,
              enabled: controller.maritalStatus.value.isNotEmpty,
            ),
          ),
        ],
      ),
    );
  }

  // 8번 페이지 : 자동차 소유 여부
  Widget _buildCarOwnershipPage() {
    return Padding(
      padding: const EdgeInsets.only(left: 47, top: 75, right: 24, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProgressDots(total: 11, current: 7),
          const SizedBox(height: 32),
          Text(
            '자동차를 소유하고 계신가요?',
            style: SurveyAssets.headingStyle.copyWith(fontSize: 24),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 12),
          Text(
            '자동차의 여부에 따라 자산 평가에 영향을 줄 수 있어요.',
            style: SurveyAssets.bodyStyle.copyWith(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            '소유한 자동차는 세대별 자동차로 보정합니다.',
            style: SurveyAssets.bodyStyle.copyWith(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 32),
          Obx(
            () => Column(
              children: [
                RadioListTile<bool>(
                  title: Text(
                    '네 가지고 있어요',
                    style: SurveyAssets.bodyStyle.copyWith(fontSize: 16),
                  ),
                  value: true,
                  groupValue: controller.hasCar.value,
                  onChanged: (value) {
                    if (value != null) {
                      controller.hasCar.value = value;
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                ),
                RadioListTile<bool>(
                  title: Text(
                    '아니요',
                    style: SurveyAssets.bodyStyle.copyWith(fontSize: 16),
                  ),
                  value: false,
                  groupValue: controller.hasCar.value,
                  onChanged: (value) {
                    if (value != null) {
                      controller.hasCar.value = value;
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SurveyButton(text: '다음', onTap: controller.nextPage, enabled: true),
        ],
      ),
    );
  }

  // 9번 페이지 : 자산 가치
  Widget _buildMyAssetPage() {
    final assetController = TextEditingController();
    return StatefulBuilder(
      builder:
          (context, setState) => Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const ProgressDots(total: 11, current: 8),
                            TextButton(
                              onPressed: controller.nextPage,
                              child: const Text(
                                '건너뛰기',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        '차량 가액을 입력해주세요.',
                        style: SurveyAssets.headingStyle.copyWith(fontSize: 24),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () async {
                          final Uri url = Uri.parse(
                            'https://www.kidi.or.kr/user/car/carprice.do',
                          );
                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              SurveyAssets.carAssetSvg,
                              width: 9,
                              height: 8,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '차량 가액 조회하기',
                              style: SurveyAssets.bodyStyle.copyWith(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () async {
                          final Uri url = Uri.parse(
                            'https://www.kidi.or.kr/user/car/carprice.do',
                          );
                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              SurveyAssets.carAssetSvg,
                              width: 9,
                              height: 8,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '차량 가액 조회하기',
                              style: SurveyAssets.bodyStyle.copyWith(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 280,
                        child: SalaryInputField(
                          hintText: '1,000',
                          controller: assetController,
                          onChanged: (value) {
                            setState(
                              () {},
                            ); // Trigger rebuild when text changes
                          },
                        ),
                      ),
                      const SizedBox(height: 40), // 버튼과의 여백
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SurveyButton(
                text: '다음',
                onTap: controller.nextPage,
                enabled: assetController.text.trim().isNotEmpty,
              ),
            ),
          ),
    );
  }

  // 10번 페이지 : 총 자산가치
  Widget _buildTotalAssetPage() {
    final assetController = TextEditingController();
    return StatefulBuilder(
      builder:
          (context, setState) => Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Skip button row
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const ProgressDots(total: 11, current: 9),
                            TextButton(
                              onPressed: controller.nextPage,
                              child: const Text(
                                '건너뛰기',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),
                      Text(
                        '총 자산가치를 입력해주세요.',
                        style: SurveyAssets.headingStyle.copyWith(fontSize: 24),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 8),

                      // Asset value lookup link
                      GestureDetector(
                        onTap: () async {
                          final Uri url = Uri.parse(
                            'https://www.nhis.or.kr/nhis/minwon/minwonServiceBoard.do?mode=view&articleNo=10945799',
                          );
                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
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
                              '내 자산 가치 조회하기',
                              style: SurveyAssets.bodyStyle.copyWith(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      SizedBox(
                        width: 280,
                        child: SalaryInputField(
                          hintText: '1,000',
                          controller: assetController,
                          onChanged: (value) {
                            setState(
                              () {},
                            ); // Trigger rebuild when text changes
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SurveyButton(
                text: '다음',
                onTap: controller.nextPage,
                enabled: assetController.text.trim().isNotEmpty,
              ),
            ),
          ),
    );
  }

  // 11번 페이지 : 기본 페이지
  Widget _buildDefaultPage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Add your default page components here
          Text(
            'Page ${controller.currentPage.value + 1}',
            style: SurveyAssets.headingStyle,
          ),
          const SizedBox(height: 16),
          Text(
            'Your survey content goes here...',
            style: SurveyAssets.bodyStyle,
          ),
        ],
      ),
    );
  }

  void _submitSurvey() {
    // Add your survey submission logic here
    controller.nextPage(); // Go to completion page
  }

  // 12번 페이지 : 완료 페이지
  Widget _buildCompletionPage() {
    return Scaffold(
      body: Column(
        children: [
          // Main content - centered in the middle of the screen
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Approval Picture
                      Image.asset(
                        SurveyAssets.approvalPicture,
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                        errorBuilder:
                            (context, error, stackTrace) => Container(
                              width: 200,
                              height: 200,
                              color: Colors.grey[200],
                              child: const Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        '조건 분석이 완료되었어요!',
                        style: SurveyAssets.headingStyle.copyWith(
                          fontSize: 24,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '고객님 조건에 맞는 공고만을 지금 바로 추천드릴게요.',
                          style: SurveyAssets.bodyStyle.copyWith(
                            fontSize: 14,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Bottom button area - fixed at the bottom
          SafeArea(
            top: false,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () => controller.goToMainPage(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.home, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      '내 조건에 맞는 공고 보기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
