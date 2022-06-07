import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_sneaker_store/core/product/product.dart';
import '../../common/app_constants.dart';

class ProductRepository {
  static final ProductRepository _productRepository = ProductRepository._internal();

  factory ProductRepository() {
    return _productRepository;
  }

  ProductRepository._internal();

  final CollectionReference _productCollection =
  FirebaseFirestore.instance.collection(AppConstants.productsCollection);

  final storage  = FirebaseStorage.instance;

  Future<List<String>> uploadImages(String id, {List<File>? newFiles, List<String>? oldFiles}) async{

    if (newFiles != null) {
      if (newFiles.isNotEmpty) {
        List<String> urls = [];
        for(int i = 0; i < newFiles.length; i++){
          String linkUri = '${AppConstants.images}/$id/$i.png';
          await storage.ref(linkUri).putFile(newFiles[i]).then((snapshot) async {
            urls.add(await snapshot.ref.getDownloadURL());
          });
        }
        return urls;
      } else {
        return oldFiles!;
      }
    } else {
      return oldFiles!;
    }
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

  Future<void> addProduct(Product product) async {
    Product newProduct = Product(
      id: product.id,
      productName: product.productName,
      description: product.description,
      price: product.price,
      sizedList: product.sizedList,
      imagesUrls: await uploadImages( product.id!, newFiles: product.imagesList!),
    );

    await _productCollection.doc(newProduct.id).set(newProduct.toJson());
  }

  void deleteProduct(Product product) {
    _productCollection.doc(product.id).delete();
  }

  Future<void> editProduct(Product product) async {
    await _productCollection.doc(product.id).set(product.toJson(), SetOptions(merge: true));
  }

  Stream collectionListener() {
    return _productCollection.snapshots();
  }
}