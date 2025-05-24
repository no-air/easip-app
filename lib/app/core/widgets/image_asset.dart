import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart' as path;


// // 기본 사용
// ImageAsset(imagePath: 'assets/images/example.svg')

// // 크기 지정
// ImageAsset(
//   imagePath: 'assets/images/example.png',
//   width: 100,
//   height: 100,
// )

// // fit 속성 변경
// ImageAsset(
//   imagePath: 'assets/images/example.svg',
//   fit: BoxFit.cover,
// )


class ImageAsset extends StatelessWidget {
  final String imagePath;
  final BoxFit fit;
  final double? width;
  final double? height;

  const ImageAsset({
    super.key,
    required this.imagePath,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final extension = path.extension(imagePath).toLowerCase();
    
    if (extension == '.svg') {
      return SvgPicture.asset(
        imagePath,
        fit: fit,
        width: width,
        height: height,
      );
    } else {
      return Image.asset(
        imagePath,
        fit: fit,
        width: width,
        height: height,
      );
    }
  }
} 