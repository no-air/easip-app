import 'package:easip_app/app/components/webview/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class PostView extends GetView {
  PostView({super.key});
  final String baseUrl = dotenv.env['WEBVIEW_URL'] ?? '';
  final String postId = Get.parameters['postId'] ?? '';

  @override
  Widget build(BuildContext context) {
    return Center(child: Webview(url: '$baseUrl/post/$postId'));
  }
}
