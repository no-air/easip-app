import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    
    if (text.isEmpty) {
      return newValue;
    }
    
    // Remove all non-digit characters
    String newText = text.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Limit to 8 digits (YYYYMMDD)
    if (newText.length > 8) {
      newText = newText.substring(0, 8);
    }
    
    // Add dots after year and month
    if (newText.length >= 5) {
      newText = '${newText.substring(0, 4)}.${newText.substring(4, 6)}.${newText.substring(6)}';
    } else if (newText.length >= 4) {
      newText = '${newText.substring(0, 4)}.${newText.substring(4)}';
    }
    
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
