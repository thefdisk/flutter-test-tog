part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteLoadedState extends FavoriteState {
  final Favorite favorite;

  const FavoriteLoadedState({this.favorite = const Favorite()});

  @override
  List<Object> get props => [favorite];
}

class FavoriteErrorState extends FavoriteState {}
