import 'package:equatable/equatable.dart';

import 'models.dart';

class Favorite extends Equatable {
  final List<Product> products;

  const Favorite({this.products = const <Product>[]});

  @override
  List<Object?> get props => [products];
}
