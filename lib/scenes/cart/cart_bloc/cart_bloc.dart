import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/product/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<OnStartupEvent>(_onStartupEvent);
    on<AddToCartEvent>(_addToCartEvent);
    on<DeleteProductEvent>(_deleteProductEvent);
    on<ClearCartEvent>(_clearCartEvent);
  }

  List<Product> productsList = [];

  Future<void> _onStartupEvent(
      OnStartupEvent event, Emitter<CartState> emit) async {
    emit(LoadingState());
    emit(CartHasDataState(productList: productsList, totalCost: 0));
  }

  Future<void> _addToCartEvent(
      AddToCartEvent event, Emitter<CartState> emit) async {
    emit(LoadingState());
    productsList.add(event.newProduct);
    double totalCost = 0;
    for (int i = 0; i < productsList.length; i++) {
      totalCost = totalCost + productsList[i].price!.toDouble();
    }
    emit(CartHasDataState(productList: productsList, totalCost: totalCost));
  }

  Future<void> _deleteProductEvent(
      DeleteProductEvent event, Emitter<CartState> emit) async {
    emit(LoadingState());
    productsList.remove(event.product);
    double totalCost = 0;
    for (int i = 0; i < productsList.length; i++) {
      totalCost = totalCost + productsList[i].price!.toDouble();
    }
    emit(CartHasDataState(productList: productsList, totalCost: totalCost));
  }

  Future<void> _clearCartEvent(
      ClearCartEvent event, Emitter<CartState> emit) async {
    emit(LoadingState());
    productsList.clear();
    emit(CartHasDataState(productList: productsList, totalCost: 0));
  }
}
