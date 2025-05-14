import 'package:get/get.dart';
import 'today_controller.dart';

class TodayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodayController>(() => TodayController());
  }
} 