import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ecom_2/app/model/product.dart';

class NewproductController extends GetxController {
  List<Product> products = [];

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  Future<void> getProducts() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getNewProduct');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success']) {
          var productData = jsonResponse['data'] as List<dynamic>;
          products.clear();
          products = productData.map((data) => Product.fromJson(data)).toList();
          update(); // Notify listeners about changes
        } else {
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.red,
            message: jsonResponse['message'],
            duration: const Duration(seconds: 3),
          ));
        }
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: 'Failed to load products',
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: const Duration(seconds: 3),
      ));
    }
  }

  void increment() => count.value++;
}
