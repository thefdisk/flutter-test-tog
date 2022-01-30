import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../data/blocs/cart/cart_bloc.dart';
import '../data/models/models.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Keranjang',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CartLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Stack(
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.only(bottom: 65),
                    shrinkWrap: true,
                    itemCount: state.cart
                        .productQuantity(state.cart.products)
                        .keys
                        .length,
                    itemBuilder: (context, index) {
                      return _buildCartProduct(
                        context,
                        product: state.cart
                            .productQuantity(state.cart.products)
                            .keys
                            .elementAt(index),
                        quantity: state.cart
                            .productQuantity(state.cart.products)
                            .values
                            .elementAt(index),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total :',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Rp ${NumberFormat.currency(
                                locale: 'id_ID',
                                decimalDigits: 0,
                                symbol: '',
                              ).format(state.cart.total)}',
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Terjadi Kesalahan'),
            );
          }
        },
      ),
    );
  }

  Widget _buildCartProduct(
    BuildContext context, {
    required Product product,
    required int quantity,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Image.network(
            product.image,
            height: 80,
            width: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  context.read<CartBloc>().add(CartProductRemoved(product));
                },
                icon: const Icon(
                  Icons.remove_circle,
                  color: Colors.redAccent,
                ),
              ),
              Text(
                quantity.toString(),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<CartBloc>().add(CartProductAdded(product));
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
}
