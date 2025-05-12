import 'package:get/get.dart';
import 'webview_controller.dart';

class WebViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WebViewController());
  }
}
