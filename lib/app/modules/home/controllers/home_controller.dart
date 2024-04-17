import 'dart:convert';

import 'package:ecom_2/app/components/addProductPopup.dart';
import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/category.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/modules/Thrift/controllers/thrift_controller.dart';
import 'package:ecom_2/app/modules/admin_products/controllers/admin_products_controller.dart';

import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  // late final SharedPreferences prefs;
  List<Category>? categories;
  List<Product>? products;
  final count = 0.obs;
  String? selectedCategory;

  final ImagePicker picker = ImagePicker();
  var addProductFormKey = GlobalKey<FormState>();
  var addCategoryFormKey = GlobalKey<FormState>();

  XFile? productImage;
  Uint8List? imageBytes;

  XFile? categoryImage;
  Uint8List? categoryImageBytes;

  //
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();

  var categoryNameController = TextEditingController();
  var isThrift = false.obs;

  @override
  void onInit() async {
    super.onInit();
    // prefs = await SharedPreferences.getInstance();
    getCategories();
    getProducts();
  }

  void onPickImage() async {
    try {
      productImage = await picker.pickImage(source: ImageSource.gallery);
      imageBytes = await productImage!.readAsBytes();
      update();
    } catch (e) {}
  }

  void onPickCategoryImage() async {
    try {
      categoryImage = await picker.pickImage(source: ImageSource.gallery);
      categoryImageBytes = await categoryImage!.readAsBytes();
      update(); // Update the UI to reflect the selected image
    } catch (e) {}
  }

  void getCategories() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getCategory');
      // await Future.delayed(const Duration(seconds: 3));

      var response = await http.get(
        url,
      );

      var result = jsonDecode(response.body);

      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //   backgroundColor: Colors.green,
        //   message: result['message'],
        //   duration: const Duration(seconds: 3),
        // ));
        categories = categoryFromJson(jsonEncode(result['data']));
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
  }

  void addProduct() async {
    try {
      if (addProductFormKey.currentState!.validate()) {
        int isThriftValue = isThrift.value ? 1 : 0;

        try {
          var url = Uri.http(ipAddress, 'ecom2_api/addProduct');

          var request = http.MultipartRequest('POST', url);

          request.fields['title'] = titleController.text;
          request.fields['description'] = descriptionController.text;
          request.fields['price'] = priceController.text;
          request.fields['category'] = selectedCategory!;
          request.fields['token'] = MemoryManagement.getAccessToken()!;
          request.fields['is_thrift'] = isThriftValue.toString();

          request.files.add(
            http.MultipartFile.fromBytes(
              'image',
              imageBytes!,
              filename: productImage!.name,
            ),
          );

          var responseData = await request.send();

          var response = await http.Response.fromStream(responseData);

          var result = jsonDecode(response.body);

          if (result['success']) {
            Get.back();
            getProducts();
            try {
              Get.find<ThriftController>().getProducts();
            } catch (e) {}
            try {
              Get.find<AdminProductsController>().getProducts();
            } catch (e) {}
            Get.showSnackbar(GetSnackBar(
              backgroundColor: Colors.green,
              message: result['message'],
              duration: const Duration(seconds: 3),
            ));
          } else {
            Get.showSnackbar(GetSnackBar(
              backgroundColor: Colors.red,
              message: result['message'],
              duration: const Duration(seconds: 3),
            ));
          }
        } catch (e) {
          Get.showSnackbar(const GetSnackBar(
            backgroundColor: Colors.red,
            message: 'Something went wrong',
            duration: Duration(seconds: 3),
          ));
        }
      }
    } catch (e) {}
  }

  void addCategory() async {
    try {
      if (addCategoryFormKey.currentState!.validate()) {
        try {
          var url = Uri.http(ipAddress, 'ecom2_api/addCategory');

          var request = http.MultipartRequest('POST', url);

          request.fields['title'] = categoryNameController.text;
          request.fields['token'] = MemoryManagement.getAccessToken()!;

          request.files.add(
            http.MultipartFile.fromBytes(
              'image',
              categoryImageBytes!,
              filename: categoryImage!.name,
            ),
          );

          var responseData = await request.send();

          var response = await http.Response.fromStream(responseData);

          var result = jsonDecode(response.body);

          if (result['success']) {
            // Clear category name field
            categoryNameController.clear();

            // Reset category image
            categoryImage = null;
            categoryImageBytes = null;

            // Close the dialog
            Get.back();

            // Show success message and refresh categories
            getCategories();
            Get.showSnackbar(GetSnackBar(
              backgroundColor: Colors.green,
              message: result['message'],
              duration: const Duration(seconds: 3),
            ));
          } else {
            Get.showSnackbar(GetSnackBar(
              backgroundColor: Colors.red,
              message: result['message'],
              duration: const Duration(seconds: 3),
            ));
          }
        } catch (e) {
          Get.showSnackbar(const GetSnackBar(
            backgroundColor: Colors.red,
            message: 'Something went wrong',
            duration: Duration(seconds: 3),
          ));
        }
      }
    } catch (e) {}
  }

  void onLogout() async {
    // await prefs.remove('token');
    MemoryManagement.removeAll();
    Get.offAllNamed(Routes.LOGIN);
  }

  void getProducts() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getProduct');
      var response = await http.get(url);

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
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
  }

  void increment() => count.value++;
}
