import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
    late final PageController pageController;
    final currentPage = 0.obs;
    final totalPages = 3;

    @override
    void onInit() {
        super.onInit();
        
        _initPageController();
    }

    void _initPageController() {
        pageController = PageController();
        pageController.addListener(() {
            currentPage.value = pageController.page?.round() ?? 0;
        });
    }

    @override
    void onClose() {
        pageController.dispose();
        super.onClose();
    }
} 