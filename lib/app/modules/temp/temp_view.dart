import 'package:easip/app/components/webview/webview_view.dart';
import 'package:easip/app/modules/temp/temp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TempView extends GetView<TempController> {
  const TempView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: WebviewView()));
  }
}
