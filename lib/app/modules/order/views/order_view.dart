import 'package:flutter/material.dart';
import 'package:ecom_2/app/components/order_card.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4eadf),
      appBar: AppBar(
        backgroundColor: Color(0XFFF4EADF),
        title: Text('Orders',
            style: GoogleFonts.gabarito(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: GetBuilder<OrderController>(
        init: OrderController(),
        builder: (controller) {
          if (controller.orders == null) {
            return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  for (var order in controller.orders!) OrderCard(order: order),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
