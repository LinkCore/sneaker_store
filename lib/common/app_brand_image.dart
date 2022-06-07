import 'package:flutter_sneaker_store/common/app_constants.dart';
import '../core/product/product.dart';

class BrandImage {
  final String asset;
  final Brands brandName;

  BrandImage({required this.brandName, required this.asset});
}

const String path = AppConstants.assetsPath;

List<BrandImage> brandImage = [
  BrandImage(asset: path + 'nike_logo.png', brandName: Brands.nike),
  BrandImage(asset: path + 'adidas_logo.png', brandName: Brands.adidas),
  BrandImage(asset: path + 'new_balance_logo.png', brandName: Brands.newBalance),
  BrandImage(asset: path + 'puma_logo.png', brandName: Brands.puma),
  BrandImage(asset: path + 'fila_logo.png', brandName: Brands.fila),
  BrandImage(asset: path + 'jordan_logo.png', brandName: Brands.jordan),
  BrandImage(asset: path + 'reebok_logo.png', brandName: Brands.reebok),
  BrandImage(asset: path + 'converse_logo.png', brandName: Brands.converse),
  BrandImage(asset: path + 'saucony_logo.png', brandName: Brands.saucony),
  BrandImage(asset: path + 'asics_logo.png', brandName: Brands.asics)
];