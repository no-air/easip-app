import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final oldText = oldValue.text;
    final newText = newValue.text;
    final oldSelection = oldValue.selection;
    final newSelection = newValue.selection;

    // 숫자만 남기기
    String digits = newText.replaceAll(RegExp(r'\D'), '');

    // 최대 8자리로 제한
    if (digits.length > 8) {
      digits = digits.substring(0, 8);
    }

    // 포맷 적용 YYYY-MM-DD
    final buffer = StringBuffer();
    int cursorPosition = newSelection.baseOffset;
    int digitIndex = 0;

    for (int i = 0; i < digits.length; i++) {
      if (i == 4 || i == 6) {
        buffer.write('-');
        if (i < cursorPosition) {
          cursorPosition++;
        }
      }
      buffer.write(digits[i]);
    }

    final formatted = buffer.toString();

    // 백스페이스 시 하이픈 처리
    final isBackspace = oldText.length > newText.length;
    if (isBackspace && oldSelection.baseOffset == newSelection.baseOffset) {
      if (cursorPosition > 0 && formatted[cursorPosition - 1] == '-') {
        cursorPosition--;
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: cursorPosition.clamp(0, formatted.length),
      ),
    );
  }
}
