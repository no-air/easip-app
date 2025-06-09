import 'package:easip_app/app/components/webview/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class HouseView extends GetView {
  HouseView({super.key});
  final baseUrl = dotenv.env['DEV_WEBVIEW_URL'] ?? '';
  final String houseId = Get.parameters['houseId'] ?? '';

  @override
  Widget build(BuildContext context) {
    return Center(child: Webview(url: '$baseUrl/house/$houseId'));
  }
}
