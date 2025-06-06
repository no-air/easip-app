import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'announcement_list_controller.dart';
import '../../core/utils/screen_utils.dart';

class AnnouncementListView extends GetView<AnnouncementListController> {
  const AnnouncementListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 44),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: controller.searchController,
                      decoration: InputDecoration(
                        hintText: '검색하기',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                        suffixIcon: Obx(
                          () =>
                              controller.searchQuery.value.isNotEmpty
                                  ? IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.grey[600],
                                    ),
                                    onPressed: controller.clearSearch,
                                  )
                                  : const SizedBox.shrink(),
                        ),
                        border: InputBorder.none,
                      ),
                      onSubmitted: controller.searchAnnouncements,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "청약 공고",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'plSemiBold',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),


                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (controller.filteredAnnouncements.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              controller.searchQuery.value.isNotEmpty
                                  ? '검색 결과가 없습니다.'
                                  : '공고가 없습니다.',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.filteredAnnouncements.length,
                      itemBuilder: (context, index) {
                        return AnnouncementRow(
                          announcement: controller.filteredAnnouncements[index],
                          onBookmarkToggle:
                              () => controller.toggleBookmark(index),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnnouncementRow extends StatelessWidget {
  final Announcement announcement;
  final VoidCallback onBookmarkToggle;

  const AnnouncementRow({
    super.key,
    required this.announcement,
    required this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: ScreenUtils.ratioWidth(context, 65),
                height: ScreenUtils.ratioWidth(context, 65),
                child: ClipRRect(
                  child: Container(
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.business,
                      size: 30,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: announcement.isActive ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    announcement.isActive ? '접수중' : '마감',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  announcement.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  announcement.periodText,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                Text(
                  announcement.recruitingText,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Obx(
            () => IconButton(
              onPressed: onBookmarkToggle,
              icon: Icon(
                Icons.bookmark_border,
                color:
                    announcement.isBookmarked.value
                        ? Colors.red
                        : Colors.grey[400],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Announcement {
  final String postId;
  final String houseThumbnailUrl;
  final String title;
  final String applicationStartDate;
  final String applicationEndDate;
  final int numberOfUnitsRecruiting;
  RxBool isBookmarked;

  Announcement({
    required this.postId,
    required this.houseThumbnailUrl,
    required this.title,
    required this.applicationStartDate,
    required this.applicationEndDate,
    required this.numberOfUnitsRecruiting,
    RxBool? isBookmarked,
  }) : isBookmarked = isBookmarked ?? false.obs;

  String get periodText => "접수일 $applicationStartDate ~ $applicationEndDate";
  String get recruitingText => "모집호수 $numberOfUnitsRecruiting";
  bool get isActive {
    try {
      final endDate = DateTime.parse(applicationEndDate);
      return DateTime.now().isBefore(endDate);
    } catch (e) {
      return true;
    }
  }
}
