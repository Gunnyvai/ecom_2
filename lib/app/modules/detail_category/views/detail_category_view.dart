import 'package:ecom_2/app/components/newproductcard.dart';
import 'package:ecom_2/app/model/category.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/detail_category_controller.dart';

class DetailCategoryView extends GetView<DetailCategoryController> {
  const DetailCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var category = Get.arguments as Category;

    return Scaffold(
      backgroundColor: Color(0xfff4eadf),
      appBar: AppBar(
        backgroundColor: Color(0xfff4eadf),
        title: Text(category.categoryTitle ?? ''),
        titleTextStyle: GoogleFonts.gabarito(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 35),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: controller.getNewProuctByCategory(category.categoryId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: controller.products.length,
                itemBuilder: (context, index) => SizedBox(
                  height: 100,
                  child: NewProductCard(
                    product: controller.products[index],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
