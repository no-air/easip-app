import '../../components/webview/webview_controller.dart';
import 'package:get/get.dart';

class TempBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WebViewController());
  }
}
