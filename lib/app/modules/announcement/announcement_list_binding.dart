import 'package:get/get.dart';
import 'announcement_list_controller.dart';

class AnnouncementListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AnnouncementListController());
  }
}
