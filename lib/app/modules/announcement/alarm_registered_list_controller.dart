import 'package:get/get.dart';
import 'model/announcement_response.dart';
import 'package:flutter/material.dart';
import '../../core/network/data_source.dart';
import '../../core/network/router/easip_router.dart';

class AlarmRegisteredListController extends GetxController {
  final announcements = Rxn<AnnouncementResponse>();
  final RxBool isLoading = false.obs;
  late final RemoteDataSource _dataSource;

  @override
  void onInit() {
    super.onInit();
    _dataSource = Get.find<RemoteDataSource>();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await _getAnnouncementList();
  }

  Future<void> _getAnnouncementList({int page = 1}) async {
    try {
      isLoading.value = true;

      final request = await EasipRouter.getRegisteredAnnouncements(page: page);
      final response = await _dataSource.execute(request);

      if (response == null) {
        throw Exception('서버에서 응답을 받지 못했습니다. 잠시 후 다시 시도해주세요.');
      }

      if (announcements.value == null) {
        announcements.value = response;
      } else {
        announcements.value = AnnouncementResponse(
          currentPage: response.currentPage,
          totalPage: response.totalPage,
          itemPerPage: response.itemPerPage,
          hasNext: response.hasNext,
          results: [...announcements.value!.results, ...response.results],
        );
      }
      debugPrint('관심 공고 리스트 로드 완료: ${response.results.length}개');
    } catch (e) {
      debugPrint('관심 공고 리스트 로드 실패: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getNextAnnouncements() async {
    if (isLoading.value || announcements.value == null) return;

    if (announcements.value?.hasNext ?? false) {
      final nextPage = (announcements.value?.currentPage ?? 0) + 1;
      await _getAnnouncementList(page: nextPage);
    }
  }
}
