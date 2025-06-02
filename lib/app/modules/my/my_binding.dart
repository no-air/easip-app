import 'package:get/get.dart';
import 'my_controller.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MyController());
  }
} 