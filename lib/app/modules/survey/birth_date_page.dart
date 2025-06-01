import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'date_input_formatter.dart';
import 'survey_controller.dart';
import 'survey_assets.dart';
import 'survey_common.dart';

class BirthDatePage extends StatefulWidget {
  final SurveyController controller;

  const BirthDatePage({Key? key, required this.controller}) : super(key: key);

  @override
  _BirthDatePageState createState() => _BirthDatePageState();
}

class _BirthDatePageState extends State<BirthDatePage> {
  late final FocusNode _birthDateFocusNode;
  late final TextEditingController _birthDateController;

  @override
  void initState() {
    super.initState();
    _birthDateFocusNode = FocusNode();
    _birthDateController = TextEditingController();
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
      final parts = date.split('.');
      if (parts.length != 3) return false;
      
      final year = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      final day = int.tryParse(parts[2]);
      
      if (year == null || month == null || day == null) return false;
      
      // Basic date validation
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight - 115, // Account for padding
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 75, bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ProgressDots(total: 11, current: 0),
                    const SizedBox(height: 12),
                    Text(
                      '생년월일을 입력해주세요',
                      style: SurveyAssets.headingStyle.copyWith(fontSize: 24),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _birthDateController,
                      focusNode: _birthDateFocusNode,
                      keyboardType: TextInputType.number,
                      style: SurveyAssets.bodyStyle.copyWith(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: '1900.01.01',
                        hintStyle: const TextStyle(color: Color(0xFF979797)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
                          borderSide: const BorderSide(color: Color(0xFF979797)),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(8), // YYYYMMDD
                        DateInputFormatter(),
                      ],
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Future.delayed(Duration.zero, () {
                          FocusScope.of(context).requestFocus(_birthDateFocusNode);
                        });
                      },
                      onChanged: (value) {
                        widget.controller.birthDate.value = value;
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '이 서비스는 성인을 대상으로 하기 때문에 미성년 이용에 제한이 있을 수 있습니다.',
                      style: SurveyAssets.bodyStyle.copyWith(fontSize: 12, color: Colors.grey[500]),
                      textAlign: TextAlign.left,
                    ),
                    const Spacer(),
                    SurveyButton(
                      text: '다음',
                      onTap: widget.controller.nextPage,
                      enabled: _birthDateController.text.length == 10 && _isValidDate(_birthDateController.text),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
