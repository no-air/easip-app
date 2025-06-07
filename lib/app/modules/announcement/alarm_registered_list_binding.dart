import 'package:get/get.dart';
import 'alarm_registered_list_controller.dart';

class AlarmRegisteredListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AlarmRegisteredListController());
  }
}
