import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  // Required properties
  final Widget title;
  final String content;

  // Optional properties with defaults
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final Color? confirmButtonColor;
  final Color? cancelButtonColor;
  final TextStyle? titleStyle; 
  final TextStyle? contentStyle;

  const CustomAlert({
    super.key,
    required this.title,
    required this.content,
    this.confirmText = '확인',
    this.cancelText = '취소',
    this.onConfirm,
    this.onCancel,
    this.confirmButtonColor = Colors.blue,
    this.cancelButtonColor = Colors.blue,
    this.titleStyle,
    this.contentStyle,
  });

  // Static show method for easy dialog display
  static Future<void> show(
    BuildContext context, {
    required dynamic title,
    required String content,
    String confirmText = '확인',
    String cancelText = '취소',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Color? confirmButtonColor = Colors.blue,
    Color? cancelButtonColor = Colors.blue,
    TextStyle? titleStyle,
    TextStyle? contentStyle,
    bool barrierDismissible = false,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => CustomAlert(
        title: title is String 
          ? Text(
              title,
              style: titleStyle ?? const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          : title,
        content: content,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        confirmButtonColor: confirmButtonColor,
        cancelButtonColor: cancelButtonColor,
        titleStyle: titleStyle,
        contentStyle: contentStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: Text(
        content,
        style: contentStyle ?? const TextStyle(
          fontSize: 14,
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Confirm button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm?.call();
              },
              child: Text(
                confirmText,
                style: TextStyle(
                  color: confirmButtonColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Cancel button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onCancel?.call();
              },
              child: Text(
                cancelText,
                style: TextStyle(
                  color: cancelButtonColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


