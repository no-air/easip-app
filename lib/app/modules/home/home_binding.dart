import 'package:get/get.dart';
import 'home_controller.dart';
import '../announcement/announcement_list_controller.dart';
import '../my/my_controller.dart';
import '../onboarding/sign_in_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(AnnouncementListController());
    Get.put(MyController());
    Get.put(SignInController());
  }
} 