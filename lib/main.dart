import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_routes.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/app_colors.dart';
import 'app/services/auth_service.dart';

void main() {
  Get.put(AuthService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Easip',
      theme: ThemeData(
        primaryColor: AppColors.eRed,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: AppRoutes.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
