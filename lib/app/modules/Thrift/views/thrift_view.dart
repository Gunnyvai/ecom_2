import 'package:ecom_2/app/components/admin_product_card.dart';
import 'package:ecom_2/app/components/thriftproductcard.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/thrift_controller.dart';

class ThriftView extends GetView<ThriftController> {
  const ThriftView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final thriftProductController = Get.put(ThriftController());

    return Scaffold(
      backgroundColor: Color(0xffF4eadf),
      appBar: AppBar(
        backgroundColor: Color(0xffF4eadf),
        title: Text('Thrift Section',
            style: GoogleFonts.gabarito(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          if (controller.categories == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: GoogleFonts.gabarito(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.THRIFTCATEGORY);
                          },
                          child: Text(
                            'See All',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff002244),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ]),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: controller.categories!.map((category) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.DETAIL_THRIFT_CATEGORY,
                                arguments: category);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff002244),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                category.categoryTitle ?? '',
                                style: GoogleFonts.gabarito(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Products",
                    style: GoogleFonts.gabarito(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GetBuilder<ThriftController>(
                    builder: (controller) => thriftProductController.products ==
                            null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                thriftProductController.products?.length ?? 0,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) => SizedBox(
                              width: 200,
                              child: ThriftProductCard(
                                product:
                                    thriftProductController.products![index],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
