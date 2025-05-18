import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class Webview extends GetView {
  Webview({super.key});

  final String url = Get.arguments ?? '';

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        cacheEnabled: true,
        clearCache: true,
      ),
      initialUrlRequest: URLRequest(url: WebUri(url)),
    );
  }
}
