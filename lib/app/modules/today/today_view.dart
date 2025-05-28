import 'package:easip_app/app/components/webview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'today_controller.dart';

class TodayView extends GetView<TodayController> {
  const TodayView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Webview(url: '/home'),
    );
  }
}
