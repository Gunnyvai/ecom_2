import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddproductController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  var selectedCategory = ''.obs;
  var categories = <String>[].obs;
  var productImage; // To hold the picked image
  var imageBytes; // To hold the bytes of the picked image

  @override
  void onInit() {
    fetchCategories(); // Fetch categories when the controller is initialized
    super.onInit();
  }

  void fetchCategories() {
    // Here, you should implement logic to fetch categories from your data source
    // For demonstration purposes, I'm populating some dummy categories
    categories.assignAll(['Category 1', 'Category 2', 'Category 3']);
  }

  Future<void> onPickImage() async {
    final picker = ImagePicker();
    productImage = await picker.pickImage(source: ImageSource.gallery);

    if (productImage != null) {
      productImage = File(productImage.path);
      imageBytes = await productImage.readAsBytes();
      update(); // Update the UI after picking the image
    }
  }

  void addProduct() {
    String title = titleController.text;
    String description = descriptionController.text;
    String price = priceController.text;

    if (title.isEmpty ||
        description.isEmpty ||
        price.isEmpty ||
        selectedCategory.value.isEmpty ||
        productImage == null) {
      Get.snackbar('Error', 'Please fill all fields');
    } else {
      print('Product Title: $title');
      print('Product Description: $description');
      print('Product Price: $price');
      print('Selected Category: ${selectedCategory.value}');
      print('Product Image Path: ${productImage.path}');

      titleController.clear();
      descriptionController.clear();
      priceController.clear();
      selectedCategory.value = '';
      productImage = null;
      imageBytes = null;

      Get.snackbar('Success', 'Product added successfully');
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.onClose();
  }
}
