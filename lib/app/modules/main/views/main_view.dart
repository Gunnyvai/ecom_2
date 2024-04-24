import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
            Icon(Icons.home_outlined, size: 30, color: Color(0xFFF4EADF)),
            Icon(Icons.list, size: 30, color: Color(0xFFF4EADF)),
            Icon(Icons.add_circle, size: 30, color: Color(0xFFF4EADF)),
            Icon(Icons.shopping_basket, size: 30, color: Color(0xFFF4EADF)),
          ],
        ),
      ),
    );
  }
}
