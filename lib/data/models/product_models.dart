import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String title;
  final String type;
  final String description;
  final String image;
  final int price;
  final int rating;

  const Product({
    required this.title,
    required this.type,
    required this.description,
    required this.image,
    required this.price,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        title: json['title'],
        type: json['type'],
        description: json['description'],
        image: json['image'],
        price: json['price'],
        rating: json['rating'],
      );

  @override
  List<Object?> get props => [
        title,
        type,
        description,
        image,
        price,
        rating,
      ];
}
