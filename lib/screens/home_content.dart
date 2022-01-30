import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../data/blocs/cart/cart_bloc.dart';
import '../data/blocs/favorite/favorite_bloc.dart';
import '../data/blocs/product/product_bloc.dart';
import '../data/models/models.dart';
import 'screens.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductLoadedState) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return _buildProductCard(context,
                    product: state.products[index]);
              },
            );
          } else {
            return const Center(child: Text('Terjadi Kesalahan'));
          }
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, {required Product product}) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            product.image,
            height: 150,
            width: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Rp ${NumberFormat.currency(
                    locale: 'id_ID',
                    decimalDigits: 0,
                    symbol: '',
                  ).format(product.price)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  product.description,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                RatingBarIndicator(
                  rating: product.rating.toDouble(),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.yellowAccent,
                  ),
                  itemCount: 5,
                  itemSize: 16,
                  unratedColor: Colors.grey,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  context.read<FavoriteBloc>().add(
                        AddFavoriteProductEvent(
                          product,
                        ),
                      );

                  const snackBar = SnackBar(
                    content: Text('Ditambahkan ke Favorite'),
                    duration: Duration(milliseconds: 500),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                icon: const Icon(Icons.favorite),
              ),
              IconButton(
                onPressed: () {
                  context.read<CartBloc>().add(CartProductAdded(product));

                  const snackBar = SnackBar(
                    content: Text('Ditambahkan ke Keranjang'),
                    duration: Duration(milliseconds: 500),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Flutter Test',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          color: Colors.pink,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FavoriteScreen(),
              ),
            );
          },
          icon: const Icon(Icons.favorite),
          padding: const EdgeInsets.all(8),
        ),
      ],
    );
  }
}
