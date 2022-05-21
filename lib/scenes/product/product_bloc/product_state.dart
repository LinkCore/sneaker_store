part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class StoreInitial extends ProductState {}

class LoadingState extends ProductState {}

class ChoiceRoleState extends ProductState {}

class ProductHasDataState extends ProductState {
  final List<Product> productList;
  final bool isUpdate;

  ProductHasDataState({required this.productList, required this.isUpdate});
}

class ErrorState extends ProductState {
  final String errorText;

  ErrorState({required this.errorText});
}
