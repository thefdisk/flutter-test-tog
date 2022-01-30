part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class StartFavoriteEvent extends FavoriteEvent {}

class AddFavoriteProductEvent extends FavoriteEvent {
  final Product product;

  const AddFavoriteProductEvent(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveFavoriteProductEvent extends FavoriteEvent {
  final Product product;

  const RemoveFavoriteProductEvent(this.product);

  @override
  List<Object> get props => [product];
}
