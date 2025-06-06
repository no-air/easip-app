import 'package:get/get.dart';
import 'announcement_list_view.dart';
import 'package:flutter/material.dart';

class AnnouncementListController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxList<Announcement> announcements = <Announcement>[].obs;
  final RxList<Announcement> filteredAnnouncements = <Announcement>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadMockData();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void _onSearchChanged() {
    searchQuery.value = searchController.text;
    _filterAnnouncements();
  }

  void loadMockData() {
    announcements.value = [
      Announcement(
        postId: "01HGW2N7EHJVJ4CJ999RRS2E97",
        houseThumbnailUrl: "",
        title: "강서구 행복주택 매입임대 공고",
        applicationStartDate: "2025.05.04",
        applicationEndDate: "2025.05.30",
        numberOfUnitsRecruiting: 430,
        isBookmarked: false.obs,
      ),
      Announcement(
        postId: "01HGW2N7EHJVJ4CJ999RRS2E98",
        houseThumbnailUrl: "",
        title: "송파구 공공임대주택 공고",
        applicationStartDate: "2025.05.10",
        applicationEndDate: "2025.06.15",
        numberOfUnitsRecruiting: 320,
        isBookmarked: false.obs,
      ),
      Announcement(
        postId: "01HGW2N7EHJVJ4CJ999RRS2E99",
        houseThumbnailUrl: "",
        title: "마포구 청년주택 매입임대 공고",
        applicationStartDate: "2025.04.01",
        applicationEndDate: "2025.04.30",
        numberOfUnitsRecruiting: 150,
        isBookmarked: false.obs,
      ),
    ];
    _filterAnnouncements();
  }

  void _filterAnnouncements() {
    if (searchQuery.value.isEmpty) {
      filteredAnnouncements.value = announcements;
    } else {
      filteredAnnouncements.value = announcements
          .where((announcement) =>
              announcement.title.toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  void searchAnnouncements(String query) {
    searchController.text = query;
  }

  void clearSearch() {
    searchController.clear();
  }

  void toggleBookmark(int index) {
    final announcement = filteredAnnouncements[index];
    final realIndex = announcements.indexWhere((item) => item.postId == announcement.postId);
    
    if (realIndex != -1) {
      announcements[realIndex].isBookmarked.value = !announcements[realIndex].isBookmarked.value;
      announcements.refresh();
      _filterAnnouncements(); 
    }
  }
}