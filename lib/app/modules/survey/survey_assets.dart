import 'package:flutter/material.dart';

class SurveyAssets {
  // Districts (25개 구)
  static const List<String> districts = [
    '강서구',
    '양천구',
    '구로구',
    '영등포구',
    '동작구',
    '금천구',
    '관악구',
    '용산구',
    '서초구',
    '강남구',
    '송파구',
    '강동구',
    '광진구',
    '중구',
    '마포구',
    '서대문구',
    '은평구',
    '종로구',
    '성북구',
    '강북구',
    '도봉구',
    '노원구',
    '중랑구',
    '동대문구',
    '성동구',
  ];
  static const String etc = '그 외';
  static const String depositHeartSvg = 'assets/icon/deposit_heart.svg';
  static const String approvalPicture = 'assets/images/survey_complete.png';
  static const String carAssetSvg = 'assets/icon/car_asset.svg';

  // Images
  static const String image1 = 'assets/survey/page1_image.png';
  static const String image2 = 'assets/survey/page2_image.png';

  // SVGs
  static const String svg1 = 'assets/survey/page1_svg.svg';
  static const String svg2 = 'assets/survey/page2_svg.svg';

  // Colors from your Figma design
  // Replace these with your actual Figma colors
  static const Color primaryColor = Color(0xFF007AFF);
  static const Color secondaryColor = Color(0xFF5856D6);

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

Widget _buildPage1() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Progress indicator (7 dots, 1 filled)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            7,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color:
                    index == 0 ? SurveyAssets.primaryColor : Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        // Title
        Text(
          '생년월일을 입력해주세요',
          style: SurveyAssets.headingStyle.copyWith(fontSize: 28),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        // Birthday TextField
        TextField(
          keyboardType: TextInputType.number,
          style: SurveyAssets.bodyStyle.copyWith(fontSize: 18),
          decoration: InputDecoration(
            hintText: '1900.01.01',
            hintStyle: TextStyle(color: Colors.grey[400]),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Subtext
        Text(
          '이 서비스는 성인을 대상으로 하기 때문에\n미성년 이용에 제한이 있을 수 있습니다.',
          style: SurveyAssets.bodyStyle.copyWith(
            fontSize: 12,
            color: Colors.grey[500],
          ),
          textAlign: TextAlign.left,
        ),
      ],
    ),
  );
}
