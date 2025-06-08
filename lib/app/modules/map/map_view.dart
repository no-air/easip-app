import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'map_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:easip_app/app/components/webview/webview.dart';

class MapView extends GetView<MapController> {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    final baseUrl = dotenv.env['BASE_URL'] ?? '';
    return Center(child: Webview(url: '$baseUrl/house-map'));
  }
}
