import 'dart:io';
import 'package:flutter_sneaker_store/core/product/product_keys.dart';

enum Brands {
  nike,
  adidas,
  newBalance,
  puma,
  fila,
  jordan,
  reebok,
  converse,
  saucony,
  asics,
  noFilter
}

class Product {
  Product({
    String? id,
    double? price,
    String? productName,
    String? description,
    List<int>? sizedList,
    List<File>? imagesList,
    List<String>? imagesUrls
  }) {
    _id = id;
    _price = price;
    _productName = productName;
    _description = description;
    _sizedList = sizedList;
    _imagesList = imagesList;
    _imagesUrls = imagesUrls;
  }

  Product.fromJson({required Map<String, dynamic> json, required String id}) {

    _id = id;
    _price = json[ProductKeys.price];
    _productName = json[ProductKeys.productName];
    _description = json[ProductKeys.description];
    _sizedList = List<int>.from(json[ProductKeys.sizedList]as List);
    _imagesUrls = List<String>.from(json[ProductKeys.imagesUrls]);
  }

  String? _id;
  double? _price;
  String? _productName;
  String? _description;
  List<int>? _sizedList;
  List<File>? _imagesList;
  List<String>? _imagesUrls;

  String? get id => _id;
  double? get price => _price;
  String? get productName => _productName;
  String? get description => _description;
  List<int>? get sizedList => _sizedList;
  List<File>? get imagesList => _imagesList;
  List<String>? get imagesUrls => _imagesUrls;

  Map<String, dynamic> toJson() {
    final productMap = <String, dynamic>{};
    productMap[ProductKeys.price] = _price;
    productMap[ProductKeys.productName] = _productName;
    productMap[ProductKeys.description] = _description;
    productMap[ProductKeys.sizedList] = _sizedList;
    productMap[ProductKeys.imagesUrls] = _imagesUrls;
    return productMap;
  }
}