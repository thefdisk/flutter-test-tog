import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../services/product_service.dart';
import '../../models/models.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService _productService;

  ProductBloc(this._productService) : super(ProductLoadingState()) {
    on<LoadProductEvent>((event, emit) async {
      emit(ProductLoadingState());

      final products = await _productService.allProducts();

      emit(ProductLoadedState(products: products));
    });
  }
}
