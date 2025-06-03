import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/screen_utils.dart';
import '../../core/widgets/image_asset.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
 const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: ScreenUtils.ratioWidth(context, 138),
                  height: ScreenUtils.ratioWidth(context, 128),
                  child: const ImageAsset(
                    imagePath: 'assets/images/onboarding4.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  '어려운 주택 청약을\n쉽게 관리하자',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'plSemiBold',
                    fontSize: 29,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 
