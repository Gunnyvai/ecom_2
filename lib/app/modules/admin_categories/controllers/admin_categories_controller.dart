import 'dart:convert';

import 'package:ecom_2/app/model/category.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/user.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminCategoriesController extends GetxController {
  //TODO: Implement AdminCategoriesController
  List<Category>? categories;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // void getCategories() async {
  //   try {
  //     var url = Uri.http(ipAddress, 'ecom2_api/getCategory');
  //     // await Future.delayed(const Duration(seconds: 3));

  //     var response = await http.get(
  //       url,
  //     );

  //     var result = jsonDecode(response.body);

  //     if (result['success']) {
  //       // Get.showSnackbar(GetSnackBar(
  //       //   backgroundColor: Colors.green,
  //       //   message: result['message'],
  //       //   duration: const Duration(seconds: 3),
  //       // ));
  //       categories = categoryFromJson(jsonEncode(result['categories']));
  //       update();
  //     } else {
  //       Get.showSnackbar(GetSnackBar(
  //         backgroundColor: Colors.red,
  //         message: result['message'],
  //         duration: const Duration(seconds: 3),
  //       ));
  //     }
  //   } catch (e) {
  //     Get.showSnackbar(const GetSnackBar(
  //       backgroundColor: Colors.red,
  //       message: 'Something went wrong',
  //       duration: Duration(seconds: 3),
  //     ));
  //   }
  // }

  void deleteCategory(String? categoryID) async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/deleteCategory');

      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'catID': categoryID
      });

      var result = jsonDecode(response.body);

      if (result['success']) {
        update();
        // getCategories();
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
        var homeController = Get.put(HomeController());
        homeController.getCategories();
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
  }

  void increment() => count.value++;
}
