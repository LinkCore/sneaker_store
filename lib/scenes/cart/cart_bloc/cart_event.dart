part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class OnStartupEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final Product newProduct;

  AddToCartEvent({required this.newProduct});
}

class DeleteProductEvent extends CartEvent {
  final Product product;

  DeleteProductEvent({required this.product});
}

class ClearCartEvent extends CartEvent {}

