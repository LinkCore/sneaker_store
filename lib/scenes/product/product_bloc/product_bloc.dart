import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../common/app_utilities.dart';
import '../../../core/product/product.dart';
import '../../../core/product/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(StoreInitial()) {
    listener.listen((snapshot) {
      add(OnStartupEvent(
          isUpdate: true, filter: Brands.noFilter, searchFilter: ''));
    });

    on<OnStartupEvent>(_onStartupEvent);
    on<AddProductEvent>(_addProductEvent);
    on<DeleteProductEvent>(_deleteProductEvent);
    on<EditProductEvent>(_editProductEvent);
  }

  Stream listener = ProductRepository().collectionListener();

  Future<void> _onStartupEvent(
      OnStartupEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    List<Product> productList = await ProductRepository().getProducts();
    productList.sort((a, b) => a.price!.compareTo(b.price!));

    if (event.searchFilter == '') {
      if (event.filter == Brands.noFilter) {
        emit(ProductHasDataState(
            productList: productList, isUpdate: event.isUpdate));
      } else {
        emit(ProductHasDataState(
            productList: productList
                .where((element) => element.productName!
                    .contains(AppUtilities.brandsEnumToString[event.filter]!))
                .toList(),
            isUpdate: event.isUpdate));
      }
    } else {
      emit(ProductHasDataState(
          productList: productList
              .where((element) =>
                  element.productName!.contains(event.searchFilter) ||
                  element.productName!
                      .toLowerCase()
                      .contains(event.searchFilter))
              .toList(),
          isUpdate: event.isUpdate));
    }
  }

  Future<void> _addProductEvent(
      AddProductEvent event, Emitter<ProductState> emit) async {
    try {
      await ProductRepository().addProduct(event.product);
    } catch (e) {
      emit(ErrorState(errorText: e.toString()));
    }
  }

  Future<void> _deleteProductEvent(
      DeleteProductEvent event, Emitter<ProductState> emit) async {
    ProductRepository().deleteProduct(event.product);
  }

  Future<void> _editProductEvent(
      EditProductEvent event, Emitter<ProductState> emit) async {
    await ProductRepository().editProduct(event.product);
  }
}