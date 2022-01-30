import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/theme.dart';
import 'data/blocs/cart/cart_bloc.dart';
import 'data/blocs/favorite/favorite_bloc.dart';
import 'data/blocs/product/product_bloc.dart';
import 'screens/home_screen.dart';
import 'services/product_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ProductService(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductBloc(
              RepositoryProvider.of<ProductService>(context),
            )..add(
                LoadProductEvent(),
              ),
          ),
          BlocProvider(
            create: (context) => FavoriteBloc()
              ..add(
                StartFavoriteEvent(),
              ),
          ),
          BlocProvider(
            create: (context) => CartBloc()
              ..add(
                CartStarted(),
              ),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Test',
          theme: theme(),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
