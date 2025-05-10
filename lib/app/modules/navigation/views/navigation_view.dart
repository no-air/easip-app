import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/navigation_controller.dart';
import '../../../theme/app_colors.dart';

class NavigationView extends GetView<NavigationController> {
  const NavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: controller.pages,
      )),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(() => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.eRed,
          unselectedItemColor: AppColors.eGray,
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icon/fish.svg',
                colorFilter: ColorFilter.mode(
                  controller.currentIndex.value == 0 ? AppColors.eRed : AppColors.eGray,
                  BlendMode.srcIn,
                ),
              ),
              label: 'TODAY',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icon/marker.svg',
                colorFilter: ColorFilter.mode(
                  controller.currentIndex.value == 1 ? AppColors.eRed : AppColors.eGray,
                  BlendMode.srcIn,
                ),
              ),
              label: '지도',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icon/list.svg',
                colorFilter: ColorFilter.mode(
                  controller.currentIndex.value == 2 ? AppColors.eRed : AppColors.eGray,
                  BlendMode.srcIn,
                ),
              ),
              label: '공고',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icon/profile.svg',
                colorFilter: ColorFilter.mode(
                  controller.currentIndex.value == 3 ? AppColors.eRed : AppColors.eGray,
                  BlendMode.srcIn,
                ),
              ),
              label: 'MY',
            ),
          ],
        )),
      ),
    );
  }
} 