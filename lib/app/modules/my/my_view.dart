import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_controller.dart';

class MyView extends GetView<MyController> {
  const MyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('MY'),
    );
  }
} 
