import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../today/views/today_view.dart';
import '../../map/views/map_view.dart';
import '../../announcement/views/announcement_view.dart';
import '../../my/views/my_view.dart';

class NavigationController extends GetxController {
  final currentIndex = 0.obs;
  late final List<Widget> pages;

  @override
  void onInit() {
    super.onInit();
    pages = [
      const TodayView(),
      const MapView(),
      const AnnouncementView(),
      const MyView(),
    ];
  }

  void changePage(int index) {
    currentIndex.value = index;
  }
}
