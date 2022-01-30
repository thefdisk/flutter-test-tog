import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../data/blocs/favorite/favorite_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Favorite',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FavoriteLoadedState) {
            final productFavorite = state.favorite.products.toSet().toList();
            return ListView.builder(
              itemCount: productFavorite.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    productFavorite[index].title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Rp ${NumberFormat.currency(
                      locale: 'id_ID',
                      decimalDigits: 0,
                      symbol: '',
                    ).format(productFavorite[index].price)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      context.read<FavoriteBloc>().add(
                          RemoveFavoriteProductEvent(
                              state.favorite.products[index]));

                      const snackBar = SnackBar(
                        content: Text('Dihapus dari Favorite'),
                        duration: Duration(milliseconds: 500),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    icon: const Icon(
                      Icons.remove_circle,
                      color: Colors.redAccent,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Terjadi Kesalahan'));
          }
        },
      ),
    );
  }
}
