import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'alarm_registered_list_controller.dart';
import 'announcement_row.dart';


class AlarmRegisteredListView extends GetView<AlarmRegisteredListController> {
  const AlarmRegisteredListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "관심 공고",
          style: TextStyle(
            fontFamily: 'plSemiBold',
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo is ScrollEndNotification) {
                  if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent * 0.8) {
                    if (controller.announcements.value?.hasNext ?? false) {
                      controller.getNextAnnouncements();
                    }
                  }
                }
                return true;
              },
              child: Obx(() {
                if (controller.announcements.value?.results.isEmpty ?? true) {
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
                          '관심 공고가 없습니다.',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: (controller.announcements.value?.results.length ?? 0) + 
                      (controller.announcements.value?.hasNext == true ? 1 : 0),
                  itemBuilder: (context, index) {
                    // 마지막 아이템이고 다음 페이지가 있는 경우 로딩 인디케이터 표시
                    if (index == (controller.announcements.value?.results.length ?? 0)) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]!),
                            ),
                          ),
                        ),
                      );
                    }

                    final announcement = controller.announcements.value?.results[index];
                    if (announcement == null) return const SizedBox.shrink();
                    
                    return AnnouncementRow(
                      announcement: announcement,
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}