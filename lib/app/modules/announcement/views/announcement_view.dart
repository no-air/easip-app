import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/announcement_controller.dart';

class AnnouncementView extends GetView<AnnouncementController> {
  const AnnouncementView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('공고'),
    );
  }
} 