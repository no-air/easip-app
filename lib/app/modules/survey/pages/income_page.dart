import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../survey_controller.dart';
import 'base_survey_page.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({Key? key}) : super(key: key);

  @override
  _IncomePageState createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  late final TextEditingController _incomeController;
  final SurveyController controller = Get.find<SurveyController>();
  final NumberFormat _numberFormat = NumberFormat('#,###');

  @override
  void initState() {
    super.initState();
    final rawValue = controller.income.value;
    _incomeController = TextEditingController(
      text: rawValue > 0 ? _numberFormat.format(rawValue) : '',
    );
  }

  @override
  void dispose() {
    _incomeController.dispose();
    super.dispose();
  }

  void _onIncomeChanged(String value) {
    final numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    final parsedValue = int.tryParse(numericValue) ?? 0;

    if (value != _numberFormat.format(parsedValue)) {
      final formattedValue =
          parsedValue > 0 ? _numberFormat.format(parsedValue) : '';
      _incomeController.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    }

    if (parsedValue > 0) {
      controller.income.value = parsedValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseSurveyPage(
      controller: controller,
      currentStep: 8,
      totalSteps: 11,
      title: '연간 소득을 입력해주세요',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          TextFormField(
            controller: _incomeController,
            decoration: const InputDecoration(
              labelText: '연간 소득 (만원 단위)',
              hintText: '예: 5,000',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                child: Text('만원'),
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            onChanged: _onIncomeChanged,
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
            },
          ),
          const SizedBox(height: 16),
          Obx(() {
            final income = controller.income.value;
            return income > 0 ? _buildIncomeInfo(income) : const SizedBox();
          }),
          const SizedBox(height: 32),
        ],
      ),
      isNextEnabled: controller.income.value > 0,
      onNextPressed: controller.income.value > 0 ? controller.nextPage : null,
    );
  }

  Widget _buildIncomeInfo(int income) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          '연간 소득: ${_numberFormat.format(income)}만원',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
