import 'package:ecom_2/app/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/favourites_controller.dart';

class FavouritesView extends GetView<FavouritesController> {
  const FavouritesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFF4EADF),
        appBar: AppBar(
          backgroundColor: Color(0XFFF4EADF),
          title: Text('Favourites',
              style: GoogleFonts.gabarito(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: GetBuilder<FavouritesController>(
          builder: (controller) => Padding(
            padding: const EdgeInsets.all(16.0),
          ),
        ));
  }
}

class FavCard extends StatelessWidget {
  final FavItem favItem;
  final int index;
  const FavCard({super.key, required this.favItem, required this.index});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<FavouritesController>();
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
                  getImageUrl(favItem.product.imageUrl),
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
                        favItem.product.title ?? '',
                        style: GoogleFonts.gabarito(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Price: Rs.${favItem.product.price}',
                        style: GoogleFonts.gabarito(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [],
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
                controller.removeFav(index);
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
