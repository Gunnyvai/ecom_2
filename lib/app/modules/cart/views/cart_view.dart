import 'package:ecom_2/app/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/cart_controller.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFF4EADF),
        appBar: AppBar(
          backgroundColor: Color(0XFFF4EADF),
          title: Text('My Cart',
              style: GoogleFonts.gabarito(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: GetBuilder<CartController>(
          builder: (controller) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.cart.length,
                      itemBuilder: (context, index) => CartCard(
                            cartItem: controller.cart[index],
                            index: index,
                          )),
                ),
                Container(
                  width: 300,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xfff5f5f5),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Text(
                        ' Total is:',
                        style: GoogleFonts.gabarito(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Obx(
                        () => Text(
                          'Rs. ${controller.total.value}',
                          style: GoogleFonts.gabarito(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (controller.cart.isEmpty) {
                            Get.showSnackbar(const GetSnackBar(
                              backgroundColor: Colors.red,
                              message: 'Cart is empty!',
                              duration: Duration(seconds: 3),
                            ));
                            return;
                          }
                          var orderId = await controller.makeOrder();
                          if (orderId == null) {
                            return;
                          }
                          KhaltiScope.of(Get.context!).pay(
                            preferences: [
                              PaymentPreference.khalti,
                              PaymentPreference.connectIPS
                            ],
                            config: PaymentConfig(
                              amount: 1000,
                              productIdentity: orderId.toString(),
                              productName: "My Product",
                            ),
                            onSuccess: (PaymentSuccessModel v) {
                              controller.makePayment(
                                  total: (v.amount / 100).toString(),
                                  orderId: orderId.toString(),
                                  otherData: v.toString());
                            },
                            onFailure: (v) {
                              Get.showSnackbar(const GetSnackBar(
                                backgroundColor: Colors.red,
                                message: 'Payment failed!',
                                duration: Duration(seconds: 3),
                              ));
                            },
                            onCancel: () {
                              Get.showSnackbar(const GetSnackBar(
                                backgroundColor: Colors.red,
                                message: 'Payment cancelled!',
                                duration: Duration(seconds: 3),
                              ));
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://web.khalti.com/static/img/logo1.png',
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Khalti Pay',
                                style: GoogleFonts.gabarito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class CartCard extends StatelessWidget {
  final CartItem cartItem;
  final int index;
  const CartCard({super.key, required this.cartItem, required this.index});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ]),
          margin: const EdgeInsets.only(bottom: 20),
          height: 120,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.network(
                  getImageUrl(cartItem.product.imageUrl),
                  fit: BoxFit.fill,
                  height: double.infinity,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        cartItem.product.title ?? '',
                        style: GoogleFonts.gabarito(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Price: Rs.${cartItem.product.price}',
                        style: GoogleFonts.gabarito(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.decreaseQuantity(index);
                            },
                            icon: Container(
                                child: Center(child: Icon(Icons.remove))),
                          ),
                          Text(
                            '${cartItem.quantity}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.increaseQuantity(index);
                            },
                            icon: Container(child: Icon(Icons.add)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                controller.removeProduct(index);
              },
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
            ),
          ),
        )
      ],
    );
  }
}
