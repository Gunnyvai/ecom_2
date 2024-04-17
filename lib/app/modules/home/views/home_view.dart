import 'package:ecom_2/app/components/product_card.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/modules/newproduct/controllers/newproduct_controller.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final newProductController = Get.put(NewproductController());

    return Scaffold(
      backgroundColor: Color(0xffF4eadf),
      appBar: AppBar(
        backgroundColor: Color(0xffF4eadf),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Color(0xff002244)),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.CART);
            },
            icon: Icon(Icons.shopping_cart, color: Color(0xff002244)),
          ),
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.PROFILE);
            },
            icon: Icon(
              Icons.person_2_outlined,
              color: Color(0xff002244),
            ),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: Color(0xfff4eadf),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xff002244),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipOval(
                      child: Image.asset(
                    'assets/fyplogo.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  )),
                  Text(
                    'Hello User',
                    style: GoogleFonts.gabarito(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                'New Products',
                style: GoogleFonts.gabarito(),
              ),
              onTap: () {
                Get.toNamed(Routes.MESSAGE);
              },
            ),
            ListTile(
              title: Text('Thrift Products', style: GoogleFonts.gabarito()),
              onTap: () {
                Get.toNamed(Routes.MESSAGE);
              },
            ),
            ListTile(
              title: Text('Favourites', style: GoogleFonts.gabarito()),
              onTap: () {
                Get.toNamed(Routes.FAVOURITES);
              },
            ),
            // Add more ListTiles for additional messages
          ],
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          if (controller.categories == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.0),
                    child: Container(
                      height: 40, // Adjust the height as needed
                      decoration: BoxDecoration(
                        color: Color(0xfff5f5f5),
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        onTap: () {
                          showSearch(context: context, delegate: SearchView());
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(fontSize: 15),
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (v) {
                          newProductController.getProducts();
                        },
                        onSubmitted: (v) {
                          newProductController.getProducts();
                        },
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Categories",
                            style: GoogleFonts.gabarito(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.NEWCATEGORY);
                            },
                            child: Text(
                              'See All',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff002244),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.categories?.length ?? 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_CATEGORY,
                                  arguments: controller.categories?[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xff002244),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  controller.categories?[index].categoryTitle ??
                                      '',
                                  style: GoogleFonts.gabarito(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: .0),
                        child: Text(
                          "Products",
                          style: GoogleFonts.gabarito(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  newProductController.products == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: newProductController.products?.length ?? 0,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) => SizedBox(
                              width: 200,
                              child: ProductCard(
                                  product:
                                      newProductController.products![index])))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SearchView extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: const Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final controller = Get.find<HomeController>();
    List<Product> suggestions = [];
    suggestions = query.trim().isEmpty
        ? []
        : controller.products
                ?.where((element) =>
                    element.title
                        ?.toLowerCase()
                        .contains(query.toLowerCase()) ??
                    false)
                .toList() ??
            [];

    if (suggestions.isEmpty) {
      return Center(child: Text("No Products found!"));
    }

    return ListView.builder(
        shrinkWrap: true,
        itemCount: suggestions.length,
        itemBuilder: (context, index) => SizedBox(
              height: 100,
              child: SearchCard(product: suggestions[index]),
            ));
  }
}
