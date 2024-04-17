import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_main_controller.dart';

class AdminMainView extends GetView<AdminMainController> {
  const AdminMainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Obx(
      () => Scaffold(
        body: controller.screens[controller.currentIndex.value],
        bottomNavigationBar: CurvedNavigationBar(
          onTap: (int val) {
            controller.currentIndex.value = val;
          },
          index: controller.currentIndex.value,
          backgroundColor: Color(0xFFF4EADF),
          color: Color(0xFF002244), // Customize icon color
          items: const [
            Icon(Icons.dashboard, size: 30, color: Color(0xFFF4EADF)),
            Icon(Icons.people, size: 30, color: Color(0xFFF4EADF)),
            Icon(Icons.category, size: 30, color: Color(0xFFF4EADF)),
            Icon(Icons.shopping_bag, size: 30, color: Color(0xFFF4EADF)),
            Icon(Icons.person, size: 30, color: Color(0xFFF4EADF)),
          ],
        ),
      ),
    );
  }
}
