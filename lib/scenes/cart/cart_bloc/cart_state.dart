part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class LoadingState extends CartState{}

class CartHasDataState extends CartState {
  final List<Product> productList;
  final double totalCost;

  CartHasDataState({required this.totalCost, required this.productList});
}
