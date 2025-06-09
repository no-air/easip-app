import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../date_input_formatter.dart';
import '../survey_controller.dart';
import '../survey_assets.dart';
import 'base_survey_page.dart';

class BirthDatePage extends StatefulWidget {
  const BirthDatePage({Key? key}) : super(key: key);

  @override
  _BirthDatePageState createState() => _BirthDatePageState();
}

class _BirthDatePageState extends State<BirthDatePage> {
  late final FocusNode _birthDateFocusNode = FocusNode();
  final TextEditingController _birthDateController = TextEditingController();
  final SurveyController controller = Get.find<SurveyController>();
  bool _isDateValid = false;

  @override
  void initState() {
    super.initState();
    // Initialize with current date if needed
    if (controller.birthDate.value != null) {
      final date = controller.birthDate.value!;
      _birthDateController.text =
          '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
      _isDateValid = _isValidDate(_birthDateController.text);
    }
  }

  @override
  void dispose() {
    _birthDateFocusNode.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  bool _isValidDate(String date) {
    if (date.length != 10) return false;
    try {
      final parts = date.split('-');
      if (parts.length != 3) return false;

      final year = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      final day = int.tryParse(parts[2]);

      if (year == null || month == null || day == null) return false;
      if (year < 1900 || year > DateTime.now().year) return false;
      if (month < 1 || month > 12) return false;
      if (day < 1 || day > 31) return false;

      // More accurate day validation
      final lastDay = DateTime(year, month + 1, 0).day;
      return day <= lastDay;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseSurveyPage(
      currentStep: 0,
      totalSteps: 11,
      title: '생년월일을 입력해주세요',
      controller: controller,
      isNextEnabled: _isDateValid,
      onNextPressed: controller.nextPage,
      showBackButton: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                TextFormField(
                  controller: _birthDateController,
                  focusNode: _birthDateFocusNode,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(
                      8,
                    ), // Limit to 8 digits (YYYYMMDD)
                    DateInputFormatter(),
                  ],
                  onChanged: (value) {
                    final isValid = value.length == 10 && _isValidDate(value);
                    if (isValid) {
                      try {
                        final parts = value.split('-');
                        final date = DateTime(
                          int.parse(parts[0]),
                          int.parse(parts[1]),
                          int.parse(parts[2]),
                        );
                        controller.birthDate.value = date;
                      } catch (e) {
                        // Handle error if needed
                      }
                    }
                    setState(() {
                      _isDateValid = isValid;
                    });
                  },
                  style: SurveyAssets.bodyStyle.copyWith(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'YYYY-MM-DD',
                    hintStyle: const TextStyle(color: Color(0xFF979797)),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF979797)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF979797)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF000000)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '이 서비스는 성인을 대상으로 하기 때문에 미성년 이용에 제한이 있을 수 있습니다.',
                  style: SurveyAssets.bodyStyle.copyWith(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
