import 'dart:convert';

import 'package:flutter/services.dart';

import '../data/models/models.dart';

class ProductService {
  Future<List<Product>> allProducts() async {
    final String string = await rootBundle.loadString('assets/db_test.json');

    final data = jsonDecode(string);

    final products = (data['products'] as List)
        .map((json) => Product.fromJson(json))
        .toList();
    return products;
  }
}
