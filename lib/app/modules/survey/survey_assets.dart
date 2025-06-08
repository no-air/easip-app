import 'package:flutter/material.dart';

class SurveyAssets {
  // Districts (25개 구)
  static const List<Map<String, String>> districts = [
    {"id": "01JWNTPSH88P6W48Q8WGBK1VHT", "name": "강남구"},
    {"id": "01JWNTPSH895VAYWW8N5P7PAX6", "name": "강동구"},
    {"id": "01JWNTPSH93S0S14D2SFN322E7", "name": "동대문구"},
    {"id": "01JWNTPSH956M5GSGBW6738E5H", "name": "광진구"},
    {"id": "01JWNTPSH95ZYCZE0BQN2NHTP6", "name": "도봉구"},
    {"id": "01JWNTPSH98VJVVXZ9HQHAQQGT", "name": "강북구"},
    {"id": "01JWNTPSH99VRNF6J59XXH8FZD", "name": "서초구"},
    {"id": "01JWNTPSH9B67PQ94NQJC45HVD", "name": "관악구"},
    {"id": "01JWNTPSH9G52C0H26AYJJKY9J", "name": "노원구"},
    {"id": "01JWNTPSH9GRRX4WR9T4KJCDS3", "name": "금천구"},
    {"id": "01JWNTPSH9NW12BP2689PRN8WY", "name": "구로구"},
    {"id": "01JWNTPSH9QRWD6XX1X56F2VBA", "name": "서대문구"},
    {"id": "01JWNTPSH9T4R2XEEMACVX8VA3", "name": "마포구"},
    {"id": "01JWNTPSH9WF29ED62DH9A1XDS", "name": "강서구"},
    {"id": "01JWNTPSH9ZGK8HA8S60YVPAG2", "name": "동작구"},
    {"id": "01JWNTPSHAA97QCTZ6EXMM68YF", "name": "양천구"},
    {"id": "01JWNTPSHAAMZ180X584RNFANN", "name": "영등포구"},
    {"id": "01JWNTPSHAHZ671MFX7GPWA47W", "name": "성동구"},
    {"id": "01JWNTPSHAJBBB3W1ECVR0PT2K", "name": "중구"},
    {"id": "01JWNTPSHAJTF3EMWJV7JT96WN", "name": "용산구"},
    {"id": "01JWNTPSHAND4HKFHKNQ1A9K7T", "name": "은평구"},
    {"id": "01JWNTPSHAWRM9QRKE3FQFB4VP", "name": "종로구"},
    {"id": "01JWNTPSHAXNHC6MCSX44SZ4PH", "name": "성북구"},
    {"id": "01JWNTPSHAXXY7N0SWY1TF73DG", "name": "중랑구"},
    {"id": "01JWNTPSHAYK8WEFJTS9ZJZY1J", "name": "송파구"},
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
    fontFamily: 'PLMedium', // Using your existing font family
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    fontFamily: 'PLLight',
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
