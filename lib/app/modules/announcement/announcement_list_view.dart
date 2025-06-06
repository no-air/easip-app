import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'announcement_list_controller.dart';
import 'announcement_row.dart';


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
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo is ScrollEndNotification) {
                        if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent * 0.8) {
                          if (controller.searchedAnnouncements.value?.hasNext ?? false) {
                            controller.getNextAnnouncements();
                          }
                        }
                      }
                      return true;
                    },
                    child: Obx(() {
                      if (controller.searchedAnnouncements.value?.results.isEmpty ?? true) {
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
                        itemCount: (controller.searchedAnnouncements.value?.results.length ?? 0) + 
                            (controller.searchedAnnouncements.value?.hasNext == true ? 1 : 0),
                        itemBuilder: (context, index) {
                          // 마지막 아이템이고 다음 페이지가 있는 경우 로딩 인디케이터 표시
                          if (index == (controller.searchedAnnouncements.value?.results.length ?? 0)) {
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

                          final announcement = controller.searchedAnnouncements.value?.results[index];
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
          ),
        ],
      ),
    );
  }
}