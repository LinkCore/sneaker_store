import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_sneaker_store/core/product/product.dart';

class ProductRepository {
  static final ProductRepository _productRepository = ProductRepository._internal();

  factory ProductRepository() {
    return _productRepository;
  }

  ProductRepository._internal();

  final CollectionReference _productCollection =
  FirebaseFirestore.instance.collection('products');

  final storage  = FirebaseStorage.instance;

  Future<List<String>> uploadImages(List<File> imagesList, String id,) async{

    List<String> urls = [];

    for(int i = 0; i < imagesList.length; i++){
      String linkUri = 'product_images/${id}/${i}.png';
      await storage.ref(linkUri).putFile(imagesList[i]).then((snapshot) async {
        urls.add(await snapshot.ref.getDownloadURL());
      });
    }
    return urls;
  }

  Future<List<Product>> getProducts() async {
    QuerySnapshot getProducts = await _productCollection.get();
    List<Product> productsList = [];

    for (var document in getProducts.docs) {
      productsList.add(Product.fromJson(
          json: (document.data()) as Map<String, dynamic>, id: document.id));
    }
    return productsList;
  }

  void addProduct(Product product) async {
    Product newProduct = Product(
      id: product.id,
      productName: product.productName,
      description: product.description,
      price: product.price,
      sizedList: product.sizedList,
      imagesUrls: await uploadImages(product.imagesList!, product.id!),
    );

    _productCollection.doc(newProduct.id).set(newProduct.toJson());

  }

  void deleteProduct(Product product) async {
    _productCollection.doc(product.id).delete();
  }

  void editProduct(Product product) async {
    _productCollection.doc(product.id).update(product.toJson());
  }

  Stream collectionListener() {
    return _productCollection.snapshots();
  }
}