import 'package:flutter/material.dart';

class SurveyActions extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final bool showSkipButton;
  final VoidCallback? onSkipPressed;
  final bool buttonEnabled;

  const SurveyActions({
    Key? key,
    required this.buttonText,
    this.onButtonPressed,
    this.showSkipButton = false,
    this.onSkipPressed,
    this.buttonEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showSkipButton)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onSkipPressed,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  '나중에 입력하기',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'PaperlogyMedium',
                  ),
                ),
              ),
            ),
          const SizedBox(height: 16),  // Fixed height spacer
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _SurveyBottomButton(
              text: buttonText,
              onPressed: onButtonPressed,
              enabled: buttonEnabled,
            ),
          ),
        ],
      ),
    );
  }
}

class _SurveyBottomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool enabled;

  const _SurveyBottomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: enabled ? Colors.black : Colors.grey[400],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
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
