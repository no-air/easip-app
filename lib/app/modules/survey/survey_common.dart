import 'package:flutter/material.dart';

class ProgressDots extends StatelessWidget {
  final int total;
  final int current;
  const ProgressDots({super.key, required this.total, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: index == current ? Colors.black : Colors.grey[300],
          shape: BoxShape.circle,
        ),
      )),
    );
  }
}

class SurveyTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? suffixText;
  final bool enabled;
  final TextAlign? textAlign;
  final void Function(String)? onChanged;
  const SurveyTextField({
    super.key, 
    required this.hint, 
    required this.controller, 
    this.keyboardType = TextInputType.text, 
    this.suffixText, 
    this.enabled = true,
    this.textAlign,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled,
      textAlign: textAlign ?? TextAlign.start,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 18),
      decoration: InputDecoration(
        hintText: hint,
        suffixText: suffixText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
      ),
    );
  }
}

class SurveyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool enabled;
  const SurveyButton({super.key, required this.text, this.onTap, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: double.infinity,
        height: 56,
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: enabled ? Colors.black : Colors.grey[400],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white, 
              fontSize: 18, 
              fontFamily: 'PaperlogyMedium',
            ),
          ),
        ),
      ),
    );
  }
}

class SurveyCheckboxGroup extends StatelessWidget {
  final List<String> options;
  final List<bool> values;
  final void Function(int, bool) onChanged;
  const SurveyCheckboxGroup({super.key, required this.options, required this.values, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: 6,
      spacing: 32,
      children: List.generate(options.length, (i) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: values[i],
            onChanged: (val) => onChanged(i, val ?? false),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            side: const BorderSide(width: 2),
          ),
          Text(options[i]),
        ],
      )),
    );
  }
}

class SurveyRadioGroup extends StatelessWidget {
  final List<String> options;
  final int? selectedIndex;
  final void Function(int?) onChanged;
  const SurveyRadioGroup({super.key, required this.options, required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: 6,
      spacing: 32,
      children: List.generate(options.length, (i) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<int>(
            value: i,
            groupValue: selectedIndex,
            onChanged: onChanged,
          ),
          Text(options[i]),
        ],
      )),
    );
  }
}
 