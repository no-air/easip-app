import 'package:easip/app/components/webview/webview_controller.dart';
import 'package:easip/app/components/webview/webview_view.dart';
import 'package:easip/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final c = Get.find<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Obx(() => Text(c.urls.value)), centerTitle: true),
      body: Center(child: WebviewView()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.offAllNamed(Routes.TEMP);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
