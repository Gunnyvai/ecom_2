import 'package:ecom_2/app/components/admin_product_card.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/admin_products_controller.dart';

class AdminProductsView extends GetView<AdminProductsController> {
  const AdminProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AdminProductsController());
    return Scaffold(
        backgroundColor: Color(0xfff4eadf),
        appBar: AppBar(
          backgroundColor: Color(0XFFF4EADF),
          title: Text('Products',
              style: GoogleFonts.gabarito(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: GetBuilder<HomeController>(
                builder: (controller) {
                  if (controller.products == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: controller.products?.length ?? 0,
                    itemBuilder: (context, index) {
                      return AdminProductCard(
                        product: controller.products![index],
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 16.0),
              child: FloatingActionButton.extended(
                backgroundColor: Color(0xff002244),
                onPressed: controller.onAdd,
                label: Text(
                  'Add Products',
                  style: GoogleFonts.gabarito(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                icon: Icon(
                  color: Colors.white,
                  Icons.add,
                ),
              ),
            ),
          ],
        ));
  }
}
