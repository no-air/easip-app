import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SalaryInputField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String? errorText;

  const SalaryInputField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.errorText,
  }) : super(key: key);

  @override
  _SalaryInputFieldState createState() => _SalaryInputFieldState();
}

class _SalaryInputFieldState extends State<SalaryInputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      style: const TextStyle(fontSize: 18, letterSpacing: 0.5),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Color(0xFF979797), fontSize: 18),
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
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black),
        ),
        suffixText: '만원',
        suffixStyle: const TextStyle(color: Colors.black, fontSize: 18),
        errorText: widget.errorText,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _SalaryInputFormatter(),
      ],
      onChanged: (value) {
        // Remove all non-digit characters and convert to integer
        final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
        if (digits.isNotEmpty) {
          final amount = int.tryParse(digits) ?? 0;
          widget.onChanged(amount.toString());
        } else {
          widget.onChanged('0');
        }
      },
    );
  }
}

class _SalaryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If new value is empty, return empty
    if (newValue.text.isEmpty) {
      return const TextEditingValue();
    }

    // Remove all non-digit characters
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Format with commas
    final formatted = _formatNumber(digits);

    // Calculate cursor position
    int cursorPosition = newValue.selection.base.offset;

    // When adding text, move cursor to the end of the input
    if (newValue.text.length > oldValue.text.length) {
      cursorPosition = newValue.text.length;
    }
    // When deleting, maintain position but ensure it's within bounds
    else if (newValue.text.length < oldValue.text.length) {
      cursorPosition = newValue.selection.base.offset;
    }

    // Ensure cursor stays in valid range
    cursorPosition = cursorPosition.clamp(0, formatted.length);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }

  String _formatNumber(String digits) {
    if (digits.isEmpty) return '';
    final number = int.tryParse(digits) ?? 0;
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
