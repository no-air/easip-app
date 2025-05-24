import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class TestWebviewController extends GetxController {
  // ... existing code ...
}

class TestWebview extends GetView<TestWebviewController> {
  const TestWebview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Webview'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.offAllNamed(Routes.home),
        ),
      ),
      body: const Center(
        child: Text('Test Webview Page'),
      ),
    );
  }
}
