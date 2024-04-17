import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddThriftProduct extends StatelessWidget {
  const AddThriftProduct({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => MaterialApp(
        home: Scaffold(
          backgroundColor: Color(0xfff4eadf),
          appBar: AppBar(
            backgroundColor: Color(0XFFF4EADF),
            title: Text(
              'Add Your Product',
              style: GoogleFonts.gabarito(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Dialog(
            backgroundColor: Color(0xfff5f5f5),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.addProductFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 16),
                      TextFormField(
                        controller: controller.titleController,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Product Name',
                          hintText: 'Enter Product Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Product Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: controller.descriptionController,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(color: Colors.black),
                        minLines: 3,
                        maxLines: 5,
                        maxLength: 500,
                        decoration: InputDecoration(
                          labelText: 'Product Description',
                          hintText: 'Enter product description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter product description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: controller.priceController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Product Price',
                          hintText: 'Enter product price',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter product price';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DropdownButtonFormField<bool>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        value: true, // Set default selection to true (Thrift)
                        items: [
                          DropdownMenuItem<bool>(
                            value: true,
                            child: const Text('Thrift'),
                          ),
                        ],
                        onChanged: (value) {
                          controller.isThrift.value = value ?? false;
                        },
                      ),
                      SizedBox(height: 16),
                      GetBuilder<HomeController>(
                        builder: (controller) => controller.categories == null
                            ? CircularProgressIndicator()
                            : DropdownButtonFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                ),
                                hint: Text('Select Category'),
                                value: controller.selectedCategory,
                                items: controller.categories!
                                    .map((category) => DropdownMenuItem(
                                          value: category.categoryId,
                                          child: Text(
                                              category.categoryTitle ?? ''),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  controller.selectedCategory = value as String;
                                },
                              ),
                      ),
                      SizedBox(height: 16),
                      controller.productImage == null ||
                              controller.imageBytes == null
                          ? ElevatedButton(
                              onPressed: controller.onPickImage,
                              child: Text(
                                'Upload Image',
                                style: TextStyle(color: Colors.white),
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
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          controller.addProduct();
                          controller.titleController.clear();
                          controller.descriptionController.clear();
                          controller.priceController.clear();
                          controller.productImage = null;
                          controller.imageBytes = null;
                        },
                        child: Text(
                          'Add Product',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF002244),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
