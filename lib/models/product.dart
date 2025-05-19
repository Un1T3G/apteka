import 'package:apteka/models/category.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final String location;
  final String phoneNumber;
  final String image;
  final int price;
  final String expirationDate;
  final Category category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.phoneNumber,
    required this.image,
    required this.price,
    required this.expirationDate,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      location: json['location'],
      phoneNumber: json['phone_number'],
      image: json['image'],
      price: json['price'],
      expirationDate: json['exprestion_date'],
      category: Category.fromJson(json['category']),
    );
  }
}
