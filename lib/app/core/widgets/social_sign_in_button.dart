import 'package:flutter/material.dart';
import '../../core/widgets/image_asset.dart';
import '../../core/utils/screen_utils.dart';

class SocialSignInButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onTap;
  final double width;
  final double height;

  const SocialSignInButton({
    super.key,
    required this.imagePath,
    this.onTap,
    this.width = 309,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtils.ratioWidth(context, width),
      height: ScreenUtils.ratioWidth(context, height),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ImageAsset(
            imagePath: imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
} 