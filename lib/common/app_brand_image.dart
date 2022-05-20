import '../core/product/product.dart';

class BrandImage {
  final String asset;
  final Brands brandsName;

  BrandImage({required this.brandsName, required this.asset});
}

List<BrandImage> brandImage = [
  BrandImage(asset: 'assets/images/nike_logo.png', brandsName: Brands.nike),
  BrandImage(asset: 'assets/images/adidas_logo.png', brandsName: Brands.adidas),
  BrandImage(
      asset: 'assets/images/new_balance_logo.png',
      brandsName: Brands.newBalance),
  BrandImage(asset: 'assets/images/puma_logo.png', brandsName: Brands.puma),
  BrandImage(asset: 'assets/images/fila_logo.png', brandsName: Brands.fila),
  BrandImage(asset: 'assets/images/jordan_logo.png', brandsName: Brands.jordan),
  BrandImage(asset: 'assets/images/reebok_logo.png', brandsName: Brands.reebok),
  BrandImage(
      asset: 'assets/images/converse_logo.png', brandsName: Brands.converse),
  BrandImage(
      asset: 'assets/images/saucony_logo.png', brandsName: Brands.saucony),
  BrandImage(asset: 'assets/images/asics_logo.png', brandsName: Brands.asics),
];
