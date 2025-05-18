import 'package:easip/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class TestWebview extends GetView {
  TestWebview({super.key});

  final String url = Get.arguments ?? '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Webview'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: InAppWebView(
                initialSettings: InAppWebViewSettings(
                  javaScriptEnabled: true,
                  cacheEnabled: true,
                  clearCache: true,
                ),
                initialUrlRequest: URLRequest(url: WebUri(url)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(
                  Routes.TEST_WEB_VIEW,
                  arguments: 'https://naver.com',
                  preventDuplicates: false,
                );
              },
              child: const Text('Open Webview(naver)'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(
                  Routes.TEST_WEB_VIEW,
                  arguments: 'https://google.com',
                  preventDuplicates: false,
                );
              },
              child: const Text('Open Webview(google)'),
            ),
          ],
        ),
      ),
    );
  }
}
