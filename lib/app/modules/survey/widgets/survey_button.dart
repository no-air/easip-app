import 'package:flutter/material.dart';

class SurveyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool enabled;
  final Color? color;
  final Color? textColor;
  final double height;
  final double? width;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const SurveyButton({
    Key? key,
    required this.text,
    this.onTap,
    this.enabled = true,
    this.color,
    this.textColor,
    this.height = 56.0,
    this.width,
    this.borderRadius = 16.0,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: enabled ? onTap : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
          padding: padding,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'PaperlogyMedium',
          ),
        ),
      ),
    );
  }
}
