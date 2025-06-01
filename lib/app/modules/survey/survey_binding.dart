import 'package:get/get.dart';
import 'survey_controller.dart';
import 'survey_view.dart';

class SurveyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurveyController>(() => SurveyController());
  }
}