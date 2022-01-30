import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<CartStarted>((event, emit) {
      emit(const CartLoaded());
    });

    on<CartProductAdded>((event, emit) {
      final state = this.state;

      if (state is CartLoaded) {
        emit(
          CartLoaded(
            cart: Cart(
              products: List.from(state.cart.products)..add(event.product),
            ),
          ),
        );
      }
    });

    on<CartProductRemoved>((event, emit) {
      final state = this.state;

      if (state is CartLoaded) {
        emit(
          CartLoaded(
            cart: Cart(
              products: List.from(state.cart.products)..remove(event.product),
            ),
          ),
        );
      }
    });
  }
}
