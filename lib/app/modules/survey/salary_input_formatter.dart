import 'package:flutter/services.dart';

class SalaryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // If text is empty, return empty
    if (newValue.text.isEmpty) {
      return const TextEditingValue();
    }

    // Remove all non-digit characters
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Format with commas
    final formatted = _formatNumber(digits);
    
    // Add '만원' at the end if there are digits
    final displayText = formatted.isNotEmpty ? '$formatted만원' : '';
    
    // Calculate cursor position
    int cursorPosition = newValue.selection.base.offset;
    
    // If we're adding text, move cursor to the end of the number part
    if (newValue.text.length > oldValue.text.length && formatted.isNotEmpty) {
      cursorPosition = formatted.length;
    }
    // If we're deleting, try to maintain position
    else if (newValue.text.length < oldValue.text.length) {
      // If we deleted a comma, adjust position
      if (cursorPosition > 0 && cursorPosition <= formatted.length && 
          formatted[cursorPosition - 1] == ',') {
        cursorPosition--;
      }
    }
    
    // Ensure cursor stays in valid range (before '만원')
    cursorPosition = cursorPosition.clamp(0, formatted.length);
    
    return TextEditingValue(
      text: displayText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
  
  String _formatNumber(String digits) {
    if (digits.isEmpty) return '';
    
    final number = int.tryParse(digits) ?? 0;
    final numberFormat = number.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    
    return numberFormat;
  }
}
