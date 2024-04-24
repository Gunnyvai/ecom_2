import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/modules/cart/controllers/cart_controller.dart';
import 'package:ecom_2/app/modules/favourites/controllers/favourites_controller.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    var favouriteController = Get.put(FavouritesController());
    var isFavorite = false.obs;
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAILED_PRODUCT, arguments: product);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white, // Background color
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: Hero(
                    tag: 'product+${product.productId}',
                    child: Image.network(
                      getImageUrl(product.imageUrl ?? ''),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10, vertical: 0), // Adjusted padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title?.toUpperCase() ?? '',
                      style: GoogleFonts.gabarito(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87, // Text color
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Rs.${product.price ?? ''}',
                      style: GoogleFonts.gabarito(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black, // Text color
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      favouriteController.addFav(product: product);
                    },
                    icon: Obx(
                      () => Icon(
                        isFavorite.value
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: isFavorite.value ? Colors.red : Colors.black87,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      cartController.addProduct(product: product);
                    },
                    icon: Icon(Icons.shopping_cart_outlined),
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchCard extends StatelessWidget {
  final Product product;
  const SearchCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    var isFavorite = false.obs;
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAILED_PRODUCT, arguments: product);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white, // Background color
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network(
                    getImageUrl(product.imageUrl ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10, vertical: 0), // Adjusted padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title?.toUpperCase() ?? '',
                      style: GoogleFonts.gabarito(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87, // Text color
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Rs.${product.price ?? ''}',
                      style: GoogleFonts.gabarito(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black, // Text color
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      isFavorite.value = !isFavorite.value;
                    },
                    icon: Obx(
                      () => Icon(
                        isFavorite.value
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: isFavorite.value ? Colors.red : Colors.black87,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      cartController.addProduct(product: product);
                    },
                    icon: Icon(Icons.shopping_cart_outlined),
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
