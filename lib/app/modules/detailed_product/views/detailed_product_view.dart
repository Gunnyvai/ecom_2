import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/modules/cart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/detailed_product_controller.dart';

class DetailedProductView extends GetView<DetailedProductController> {
  const DetailedProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.arguments as Product;
    var cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          product.title?.toUpperCase() ?? '',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20), // Add padding to all sides
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 16,
                child: Hero(
                  tag: 'product+${product.productId}',
                  child: Image.network(
                    getImageUrl(product.imageUrl ?? ''),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title?.toUpperCase() ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    product.description ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Rs.${product.price ?? ''}',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  product.isThrift == '1'
                      ? Text(
                          'Used',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : product.isThrift == '0'
                          ? Text(
                              'BrandNew',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : SizedBox(),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (controller.quantity > 1) {
                        controller.quantity--;
                      }
                    },
                    icon: Icon(Icons.remove),
                  ),
                  Obx(
                    () => Text(
                      controller.quantity.toString(),
                      style: GoogleFonts.poppins(fontSize: 20),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.quantity++;
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          cartController.addProduct(
            product: product,
            quantity: controller.quantity.value,
          );
        },
        label: Text(
          'Add to Cart',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        icon: Icon(
          Icons.shopping_cart_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
