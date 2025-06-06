import 'package:get/get.dart';
import 'model/announcement_response.dart';
import 'package:flutter/material.dart';
import '../../core/network/data_source.dart';
import '../../core/network/router/easip_router.dart';
import 'dart:async';

class AnnouncementListController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final announcements = Rxn<AnnouncementResponse>();
  final searchedAnnouncements = Rxn<AnnouncementResponse>();
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  Timer? _debounce;
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
    searchController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    _debounce?.cancel();
    searchController.dispose();
    super.onClose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchQuery.value = searchController.text;
      _getSearchAnnouncements();
    });
  }

  Future<void> _getAnnouncementList({int page = 1}) async {
    try {
      isLoading.value = true;

      final request = await EasipRouter.getAnnouncements(page: page);
      final response = await _dataSource.execute(request);

      if (response == null) {
        throw Exception('서버에서 응답을 받지 못했습니다. 잠시 후 다시 시도해주세요.');
      }

      if (announcements.value == null) {
        announcements.value = response;
        searchedAnnouncements.value = response;
      } else {
        announcements.value = AnnouncementResponse(
          currentPage: response.currentPage,
          totalPage: response.totalPage,
          itemPerPage: response.itemPerPage,
          hasNext: response.hasNext,
          results: [...announcements.value!.results, ...response.results],
        );

        searchedAnnouncements.value = announcements.value;
      }
      debugPrint('공고 리스트 로드 완료: ${response.results.length}개');
    } catch (e) {
      debugPrint('공고 리스트 로드 실패: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _getSearchAnnouncements({int page = 1}) async {
    if (searchQuery.value.isEmpty) {
      searchedAnnouncements.value = announcements.value;
      return;
    }

    try {
      isLoading.value = true;

      final request = await EasipRouter.getAnnouncements(
        keyword: searchQuery.value,
        page: page,
      );
      final response = await _dataSource.execute(request);

      if (response == null) {
        throw Exception('검색 결과를 받지 못했습니다. 잠시 후 다시 시도해주세요.');
      }

      if (searchedAnnouncements.value == null || page == 1) {
        searchedAnnouncements.value = response;
      } else {
        searchedAnnouncements.value = AnnouncementResponse(
          currentPage: response.currentPage,
          totalPage: response.totalPage,
          itemPerPage: response.itemPerPage,
          hasNext: response.hasNext,
          results: [
            ...searchedAnnouncements.value!.results,
            ...response.results,
          ],
        );
      }
      debugPrint('검색 결과 로드 완료: ${response.results.length}개');
    } catch (e) {
      debugPrint('검색 실패: $e');
      searchedAnnouncements.value = announcements.value;
    } finally {
      isLoading.value = false;
    }
  }

  void searchAnnouncements(String query) {
    searchController.text = query;
  }

  void clearSearch() {
    searchController.clear();
    searchedAnnouncements.value = announcements.value;
  }

  Future<void> getNextAnnouncements() async {
    if (isLoading.value || searchedAnnouncements.value == null) return;

    if (searchQuery.value.isEmpty) {
      // 일반
      if (announcements.value?.hasNext ?? false) {
        final nextPage = (announcements.value?.currentPage ?? 0) + 1;
        await _getAnnouncementList(page: nextPage);
      }
    } else {
      // 검색
      if (searchedAnnouncements.value?.hasNext ?? false) {
        final nextPage = (searchedAnnouncements.value?.currentPage ?? 0) + 1;
        await _getSearchAnnouncements(page: nextPage);
      }
    }
  }
}
