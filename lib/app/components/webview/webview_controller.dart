import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class WebViewController extends GetxController {
  var urls = "https://google.com".obs;

  Rx<WebViewEnvironment?> webViewEnvironment = Rx<WebViewEnvironment?>(null);
  Rx<InAppWebViewController?> webViewController = Rx<InAppWebViewController?>(
    null,
  );
  Rx<PullToRefreshController?> pullToRefreshController =
      Rx<PullToRefreshController?>(null);
}
