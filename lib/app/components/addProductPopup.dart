import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductPopup extends StatelessWidget {
  const AddProductPopup({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Dialog(
        backgroundColor: Color(0xffe6e6fa),
        insetPadding: const EdgeInsets.all(30),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: controller.addProductFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add Product',
                    style: GoogleFonts.gabarito(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  TextFormField(
                    controller: controller.titleController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Product Name',
                      labelStyle: GoogleFonts.gabarito(),
                      hintText: 'Enter Product Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // Product Description
                  TextFormField(
                    controller: controller.descriptionController,
                    textInputAction: TextInputAction.next,
                    minLines: 3,
                    maxLines: 5,
                    maxLength: 500,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Product Description',
                      labelStyle: GoogleFonts.gabarito(),
                      hintText: 'Enter Product Description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Product Description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // Product Price
                  TextFormField(
                    controller: controller.priceController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Product Price',
                      labelStyle: GoogleFonts.gabarito(),
                      hintText: 'Enter Product Price',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Product Price';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  DropdownButtonFormField<bool>(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Product Type',
                      labelStyle: GoogleFonts.gabarito(),
                      hintText: 'Select product type',
                      border: OutlineInputBorder(),
                    ),
                    value: null,
                    items: [
                      DropdownMenuItem<bool>(
                        value: true,
                        child: const Text('Thrift'),
                      ),
                      DropdownMenuItem<bool>(
                        value: false,
                        child: const Text('New'),
                      ),
                    ],
                    onChanged: (value) {
                      controller.isThrift.value = value ?? false;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  GetBuilder<HomeController>(
                    builder: (controller) => controller.categories == null
                        ? const CircularProgressIndicator()
                        : DropdownButtonFormField(
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(),
                            ),
                            hint: const Text('Select Category'),
                            style: GoogleFonts.gabarito(),
                            value: controller.selectedCategory,
                            items: controller.categories!
                                .map((category) => DropdownMenuItem(
                                      value: category.categoryId,
                                      child: Text(
                                        category.categoryTitle ?? '',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              controller.selectedCategory = value as String;
                            },
                          ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // Upload Image Button or Display Image
                  controller.productImage == null ||
                          controller.imageBytes == null
                      ? ElevatedButton(
                          onPressed: controller.onPickImage,
                          child: Text(
                            'Upload Image',
                            style: GoogleFonts.gabarito(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        )
                      : Image.memory(controller.imageBytes!),
                  const SizedBox(
                    height: 16,
                  ),
                  // Add Product Button
                  ElevatedButton(
                    onPressed: controller.addProduct,
                    child: Text(
                      'Add Product',
                      style: GoogleFonts.gabarito(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF002244),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
