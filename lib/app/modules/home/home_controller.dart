import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../today/today_view.dart';
import '../map/map_view.dart';
import '../announcement/announcement_view.dart';
import '../my/my_view.dart';

class HomeController extends GetxController {
  int currentIndex = 0;
  late List<Widget> pages;

  @override
  void onInit() {
    super.onInit();
    pages = [
      TodayView(),
      const MapView(),
      const AnnouncementView(),
      const MyView(),
    ];
  }

  void changePage(int index) {
    currentIndex = index;
    update();
  }
} 
