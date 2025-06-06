import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../today/today_view.dart';
import '../map/map_view.dart';
import '../announcement/announcement_list_view.dart';
import '../my/my_view.dart';

class HomeController extends GetxController {
  int currentIndex = 0;
  late final List<Widget> pages;

  @override
  void onInit() {
    super.onInit();
    
    // Get.put(MyController());
    // Get.put(AnnouncementListController());
    
    pages = [
      TodayView(),
      const MapView(),
      const AnnouncementListView(),
      const MyView(),
    ];
  }

  void changePage(int index) {
    if (currentIndex != index) {
      currentIndex = index;
      update();
    }
  }
} 
