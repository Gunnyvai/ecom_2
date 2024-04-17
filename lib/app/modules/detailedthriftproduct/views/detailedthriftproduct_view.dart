import 'package:ecom_2/app/components/My_button.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:flutter/material.dart';
import 'package:ecom_2/app/constants.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/detailedthriftproduct_controller.dart';

class DetailedthriftproductView
    extends GetView<DetailedthriftproductController> {
  const DetailedthriftproductView({Key? key}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    var product = Get.arguments as Product;

    return Scaffold(
      backgroundColor: Color(0xfff4eadf),
      appBar: AppBar(
        backgroundColor: Color(0xfff4eadf),
        title: Text(product.title?.toUpperCase() ?? ''),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'product+${product.productId}',
                child: Image.network(
                  width: double.infinity,
                  height: Get.height * 0.4,
                  getImageUrl(product.imageUrl ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title?.toUpperCase() ?? '',
                      style: GoogleFonts.gabarito(
                          fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      product.description ?? '',
                      style: GoogleFonts.gabarito(
                          fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      'Rs.' + product.price.toString(),
                      style: GoogleFonts.gabarito(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.green[800]),
                    ),
                    // Display thrift or new indication if available
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
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          // children: [
          //   IconButton(
          //     onPressed: () {
          //       if (controller.quantity > 1) {
          //         controller.quantity--;
          //       }
          //     },
          //     icon: Icon(Icons.remove),
          //   ),
          //   Obx(
          //     () => Text(
          //       controller.quantity.toString(),
          //       style: GoogleFonts.gabarito(fontSize: 25),
          //     ),
          //   ),
          //   IconButton(
          //     onPressed: () {
          //       controller.quantity++;
          //     },
          //     icon: Icon(Icons.add),
          //   ),
          // ],
          // ),
          FloatingActionButton.extended(
            onPressed: () {
              callnumber(product);
            },
            backgroundColor: Colors.red[900],
            label: Text(
              'Contact',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            icon: Icon(
              Icons.call,
              color: Colors.white,
            ),
            hoverColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}

callnumber(Product product) async {
  if (product.phoneNumber != null) {
    // Check if user and phone number are available
    String phoneNumber = product.phoneNumber!; // Accessing user's phone number
    String url = 'tel:$phoneNumber'; // Creating tel URL
    await launch(url); // Launching phone app with the provided phone number
  } else {
    // Handle case where user or phone number is not available
    // You can show a snackbar or toast to inform the user
    Get.showSnackbar(const GetSnackBar(
      backgroundColor: Colors.red,
      message: 'Phone number not available',
      duration: Duration(seconds: 3),
    ));
  }
}
