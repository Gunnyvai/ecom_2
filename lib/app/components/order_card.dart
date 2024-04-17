import 'package:flutter/material.dart';
import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/order.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // Change card background color
      margin: EdgeInsets.only(bottom: 20),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order: #' + order.orderId.toString(),
                  style: GoogleFonts.gabarito(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  formatDate(order.orderDate),
                  style:
                      GoogleFonts.gabarito(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 10),
            if (MemoryManagement.getAccessRole() == 'admin') ...[
              Text(
                order.fullName ?? '',
                style: GoogleFonts.gabarito(fontSize: 16, color: Colors.black),
              ),
              Text(
                order.email ?? '',
                style: GoogleFonts.gabarito(fontSize: 16, color: Colors.black),
              ),
              SizedBox(height: 10),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.status == 'paid' ? 'Paid' : 'Failed',
                  style: GoogleFonts.gabarito(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color:
                          order.status == 'paid' ? Colors.green : Colors.red),
                ),
                Text(
                  'Rs.' + order.total.toString(),
                  style: GoogleFonts.gabarito(
                      fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
