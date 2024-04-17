import 'dart:convert';
import 'dart:typed_data';

import 'package:ecom_2/app/components/addProductPopup.dart';
import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminProductsController extends GetxController {
  List<Product> products = [];

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  void getProducts() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getProduct');
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

  void onAdd() {
    showDialog(
        context: Get.context!, builder: (context) => const AddProductPopup());
  }

  void onDeleteClicked({required String productId}) async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/deleteProduct');

      var response = await http.post(url, body: {
        'product_id': productId,
        'token': MemoryManagement.getAccessToken()
      });

      var result = jsonDecode(response.body);

      if (result['success']) {
        update();
        getProducts();
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
        var homeController = Get.put(HomeController());
        homeController.getProducts();
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
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
}
