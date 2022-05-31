import 'package:flutter/material.dart';
import '../core/product/product.dart';
import '../core/user/roles.dart';

class AppUtilities {

  static const Map<Roles, String> rolesEnumToString = {
    Roles.seller: "Seller",
    Roles.buyer: "Buyer"
  };

  static const Map<String, Roles> stringToRolesEnum = {
    "Seller": Roles.seller,
    "Buyer": Roles.buyer
  };

  static const Map<Brands, String> brandsEnumToString = {
    Brands.nike: "Nike",
    Brands.adidas: "Adidas",
    Brands.newBalance: "New Balance",
    Brands.puma: "Puma",
    Brands.fila: "Fila",
    Brands.jordan: "Jordan",
    Brands.reebok: "Reebok",
    Brands.converse: "Converse",
    Brands.saucony: "Saucony",
    Brands.asics: "Asics"
  };

  static List<int> sizeList = List.generate(15, (index) => index+36);
}