import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/addproduct_controller.dart';

class AddproductView extends GetView<AddproductController> {
  const AddproductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AddproductController());

    return Scaffold(
      backgroundColor: Color(0xfff4eadf),
      appBar: AppBar(
        title: const Text('Add Product'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: controller.titleController,
              decoration: const InputDecoration(labelText: 'Product Title'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: controller.descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: controller.priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            GetBuilder<HomeController>(
              builder: (controller) => controller.categories == null
                  ? const CircularProgressIndicator()
                  : DropdownButtonFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      hint: const Text('Select Category'),
                      value: controller.selectedCategory,
                      items: controller.categories!
                          .map((category) => DropdownMenuItem(
                                value: category.categoryId,
                                child: Text(category.categoryTitle ?? ''),
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
            controller.productImage == null || controller.imageBytes == null
                ? ElevatedButton(
                    onPressed: controller.onPickImage,
                    child: const Text(
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: controller.addProduct,
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
