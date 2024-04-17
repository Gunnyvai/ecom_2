import 'package:ecom_2/app/components/addthriftproduct.dart';
import 'package:ecom_2/app/modules/Thrift/views/thrift_view.dart';
import 'package:ecom_2/app/modules/addproduct/views/addproduct_view.dart';
import 'package:ecom_2/app/modules/home/views/home_view.dart';
import 'package:ecom_2/app/modules/order/views/order_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  List<Widget> screens = [
    const HomeView(),
    const OrderView(),
    const AddThriftProduct(),
    const ThriftView()
  ];

  var currentIndex = 0.obs;

  final count = 0.obs;

  void increment() => count.value++;
}
