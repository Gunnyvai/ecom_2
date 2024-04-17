import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/category.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailCategoryController extends GetxController {
  List<Product> products = [];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    var homeController = Get.find<HomeController>();
    var category = Get.arguments as Category;
    // products = getNewProuctByCategory();
  }

  getNewProuctByCategory(String? categoryID) async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getNewProductbyCategory');
      var response = await http.post(url, body: {
        'category_id': categoryID,
      });

      var result = jsonDecode(response.body);

      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //   backgroundColor: Colors.green,
        //   message: result['message'],
        //   duration: const Duration(seconds: 3),
        // ));

        products = productFromJson(
          jsonEncode(result['data']),
        );
        update();
        return products;
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
      return null;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
