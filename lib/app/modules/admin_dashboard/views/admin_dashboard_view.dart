import 'package:ecom_2/app/components/My_button.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/admin_dashboard_controller.dart';

class AdminDashboardView extends GetView<AdminDashboardController> {
  const AdminDashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFF4EADF),
        appBar: AppBar(
          backgroundColor: Color(0XFFF4EADF),
          title: Text('Dashboard',
              style: GoogleFonts.gabarito(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<AdminDashboardController>(
                init: AdminDashboardController(),
                builder: (controller) {
                  if (controller.stats == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      // await Future.delayed(Duration(seconds: 5));
                      await controller.getStats();
                    },
                    child: GridView(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5),
                        children: [
                          StatsCard(
                            label: 'Total Income',
                            icon: Icon(Icons.money_rounded,
                                color: Color(0xfff4eadf)),
                            isAmount: true,
                            value:
                                controller.stats?.totalIncome.toString() ?? '',
                          ),
                          StatsCard(
                            label: 'Total Users',
                            icon: Icon(Icons.person_2_outlined,
                                color: Color(0xfff4eadf)),
                            value:
                                controller.stats?.totalUsers.toString() ?? '',
                          ),
                          StatsCard(
                            label: 'Total Products',
                            icon: Icon(
                              Icons.shopping_bag,
                              color: Color(0xfff4eadf),
                            ),
                            value: controller.stats?.totalProducts.toString() ??
                                '',
                          ),
                          StatsCard(
                            label: 'Total Orders',
                            icon: Icon(Icons.book_online_rounded,
                                color: Color(0xfff4eadf)),
                            value:
                                controller.stats?.totalOrders.toString() ?? '',
                          ),
                          StatsCard(
                            label: 'Total Thrifts',
                            icon: Icon(Icons.shopping_basket_outlined,
                                color: Color(0xfff4eadf)),
                            value: controller.stats?.totalThriftProduct
                                    .toString() ??
                                '',
                          )
                        ]),
                  );
                },
              ),
              Container(
                height: 50,
                width: 200, // Adjust the width as needed
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff002244), // Change color here
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.ORDER);
                    },
                    child: Text(
                      'View Orders',
                      style: GoogleFonts.gabarito(
                          color: Color(0xfff4eadf),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class StatsCard extends StatelessWidget {
  final String label;
  final String value;
  final Icon? icon;
  final bool isAmount;
  final Color? color;
  const StatsCard(
      {super.key,
      required this.label,
      required this.value,
      this.isAmount = false,
      this.color,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            spreadRadius: 2,
            color: Colors.black.withOpacity(0.2),
            offset: Offset(1, 1))
      ], color: color ?? Color(0xff002244)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            (isAmount ? 'Rs.' : '') + value,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xfff4eadf),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 20, color: Color(0xfff4eadf)),
              ),
              icon ?? SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }
}
