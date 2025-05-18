import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'announcement_controller.dart';

class AnnouncementView extends GetView<AnnouncementController> {
  const AnnouncementView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('공고'),
    );
  }
} 
