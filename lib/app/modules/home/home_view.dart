import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_controller.dart';
import '../../theme/app_colors.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (controller) => IndexedStack(
          index: controller.currentIndex,
          children: controller.pages,
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: GetBuilder<HomeController>(
          builder: (controller) => BottomNavigationBar(
            currentIndex: controller.currentIndex,
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
                    controller.currentIndex == 0 ? AppColors.eRed : AppColors.eGray,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'TODAY',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icon/marker.svg',
                  colorFilter: ColorFilter.mode(
                    controller.currentIndex == 1 ? AppColors.eRed : AppColors.eGray,
                    BlendMode.srcIn,
                  ),
                ),
                label: '지도',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icon/list.svg',
                  colorFilter: ColorFilter.mode(
                    controller.currentIndex == 2 ? AppColors.eRed : AppColors.eGray,
                    BlendMode.srcIn,
                  ),
                ),
                label: '공고',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icon/profile.svg',
                  colorFilter: ColorFilter.mode(
                    controller.currentIndex == 3 ? AppColors.eRed : AppColors.eGray,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'MY',
              ),
            ],
          ),
        ),
      ),
    );
  }
} 