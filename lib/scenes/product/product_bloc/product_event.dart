part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class OnStartupEvent extends ProductEvent {
  final bool isUpdate;
  final Brands filter;
  final String searchFilter;

  OnStartupEvent(
      {required this.searchFilter,
        required this.isUpdate,
        required this.filter});
}

class AddProductEvent extends ProductEvent {
  final Product product;

  AddProductEvent({required this.product});
}

class DeleteProductEvent extends ProductEvent {
  final Product product;

  DeleteProductEvent({required this.product});
}

class EditProductEvent extends ProductEvent {
  final Product product;

  EditProductEvent({required this.product});
}
