import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyInfoRow extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool isEditMode;
  final String Function(String) formatValue;

  const MyInfoRow({
    super.key,
    required this.label,
    required this.controller,
    required this.inputType,
    required this.isEditMode,
    required this.formatValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'plMedium',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: isEditMode
                  ? SizedBox(
                      width: 150,
                      child: TextField(
                        controller: controller,
                        keyboardType: inputType,
                        textAlign: TextAlign.right,
                        inputFormatters: inputType == TextInputType.number
                            ? [FilteringTextInputFormatter.digitsOnly]
                            : null,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: const TextStyle(
                          fontFamily: 'plMedium',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                    )
                  : Text(
                      formatValue(controller.text),
                      style: const TextStyle(
                        fontFamily: 'plMedium',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// 토글 버튼 - 주택여부, 전형
class MyToggleRow extends StatelessWidget {
  final String label;
  final List<String> options;
  final dynamic currentValue;
  final Function(dynamic) onChanged;
  final bool isEditMode;
  final String Function(dynamic) getDisplayText;

  const MyToggleRow({
    super.key,
    required this.label,
    required this.options,
    required this.currentValue,
    required this.onChanged,
    required this.isEditMode,
    required this.getDisplayText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'plMedium',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          isEditMode
              ? Wrap(
                  spacing: 8,
                  children: options.asMap().entries.map((entry) {
                    int index = entry.key;
                    String option = entry.value;
                    bool isSelected = currentValue == index;
                    
                    return GestureDetector(
                      onTap: isEditMode ? () => onChanged(index) : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? Colors.blue : Colors.white,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          option,
                          style: TextStyle(
                            fontFamily: 'plMedium',
                            fontSize: 14,
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )
              : Wrap(
                  spacing: 8,
                  children: options.asMap().entries.map((entry) {
                    int index = entry.key;
                    String option = entry.value;
                    bool isSelected = currentValue == index;
                    
                    return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.white,
                          width: 1,
                        ),
                  ),
                  child: Text(
                        option,
                        style: TextStyle(
                          fontFamily: 'plMedium',
                      fontSize: 14,
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}

// 칩 버튼 - 선호지역, 거주지역
class MyChipRow extends StatelessWidget {
  final String label;
  final List<String> values;
  final bool isSelected;

  const MyChipRow({
    super.key,
    required this.label,
    required this.values,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'plMedium',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          Wrap(
            spacing: 8,
            children: values.where((v) => v.isNotEmpty).map((value) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                value,
                style: TextStyle(
                  fontFamily: 'plMedium',
                  fontSize: 14,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
} 