import 'package:ecom_2/app/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/newproduct_controller.dart';
// Import your product card widget here

class NewproductView extends GetView<NewproductController> {
  const NewproductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Product View'),
        centerTitle: true,
      ),
      body: GetBuilder<NewproductController>(
        builder: (controller) {
          if (controller.products == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.products?.length ?? 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return ProductCard(product: controller.products![index]);
            },
          );
        },
      ),
    );
  }
}
