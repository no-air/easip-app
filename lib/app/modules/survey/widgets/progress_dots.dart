import 'package:flutter/material.dart';

class ProgressDots extends StatelessWidget {
  final int total;
  final int current;
  final double activeSize;
  final double inactiveSize;
  final Color activeColor;
  final Color inactiveColor;

  const ProgressDots({
    Key? key,
    required this.total,
    required this.current,
    this.activeSize = 8.0,
    this.inactiveSize = 6.0,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index) {
        final isActive = index == current;
        return Container(
          width: isActive ? activeSize : inactiveSize,
          height: isActive ? activeSize : inactiveSize,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
