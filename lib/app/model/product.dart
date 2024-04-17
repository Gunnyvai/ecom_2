import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  final String? productId;
  final String? title;
  final String? description;
  final String? categoryId;
  final String? imageUrl;
  final String? isAvailable;
  final String? isThrift;
  final String? price;
  final String? categoryTitle;
  final String? userId;
  final String? phoneNumber;

  Product(
      {this.productId,
      this.title,
      this.description,
      this.categoryId,
      this.imageUrl,
      this.isAvailable,
      this.isThrift,
      this.price,
      this.categoryTitle,
      this.userId,
      this.phoneNumber});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      productId: json["product_id"],
      title: json["title"],
      description: json["description"],
      categoryId: json["category_id"],
      imageUrl: json["image_url"],
      isAvailable: json["is_available"],
      isThrift: json["is_thrift"],
      price: json["price"],
      phoneNumber: json["phone_number"],
      categoryTitle: json["category_title"],
      userId: json["user_id"]);

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "title": title,
        "description": description,
        "category_id": categoryId,
        "image_url": imageUrl,
        "is_available": isAvailable,
        "is_thrift": isThrift,
        "price": price,
        "category_title": categoryTitle,
        "user_id": userId,
        "phone_number": phoneNumber
      };
}
