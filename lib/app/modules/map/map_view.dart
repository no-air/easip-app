import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'map_controller.dart';

class MapView extends GetView<MapController> {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('지도'),
    );
  }
} 
