import 'dart:convert';

import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouritesController extends GetxController {
  List<FavItem> userFav = [];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    mapFav();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  void addFav({required Product product}) {
    if (userFav
        .any((element) => element.product.productId == product.productId)) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Product already in cart!',
        duration: Duration(seconds: 3),
      ));
      return;
    }
    userFav.add(FavItem(product: product));
    updateLocal();
    Get.showSnackbar(const GetSnackBar(
      backgroundColor: Colors.green,
      message: "Product added to Favourites",
      duration: Duration(seconds: 2),
    ));
  }

  void mapFav() {
    var userFav =
        jsonDecode(MemoryManagement.getFav() ?? '[]') as List<dynamic>;
    this.userFav = userFav
        .map((e) => FavItem(product: Product.fromJson(e['product'])))
        .toList();
  }

  void updateLocal() {
    MemoryManagement.setFav(jsonEncode(userFav
        .map((e) => {
              'product': e.product.toJson(),
            })
        .toList()));
  }

  void removeFav(int index) {
    userFav.removeAt(index);
    updateLocal();
    update();
  }
}

class FavItem {
  final Product product;

  FavItem({required this.product});
}
