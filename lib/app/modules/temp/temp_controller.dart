import 'package:easip/app/components/webview/webview_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class TempController extends GetxController {
  final c = Get.find<WebViewController>();

  @override
  void onReady() {
    super.onReady();

    if (kDebugMode) {
      print("TempController: ${c.urls.value}");
      print("webViewController: ${c.webViewController.value}");
    }

    c.urls.value = "https://www.naver.com";
    c.webViewController.value?.loadUrl(
      urlRequest: URLRequest(url: WebUri(c.urls.value)),
    );
  }
}
