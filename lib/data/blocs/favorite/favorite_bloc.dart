import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteLoadingState()) {
    on<StartFavoriteEvent>((event, emit) {
      emit(const FavoriteLoadedState());
    });

    on<AddFavoriteProductEvent>((event, emit) {
      final state = this.state;

      if (state is FavoriteLoadedState) {
        emit(
          FavoriteLoadedState(
            favorite: Favorite(
              products: List.from(state.favorite.products)..add(event.product),
            ),
          ),
        );
      }
    });

    on<RemoveFavoriteProductEvent>((event, emit) {
      final state = this.state;

      if (state is FavoriteLoadedState) {
        emit(
          FavoriteLoadedState(
            favorite: Favorite(
              products: List.from(state.favorite.products)
                ..remove(event.product),
            ),
          ),
        );
      }
    });
  }
}
