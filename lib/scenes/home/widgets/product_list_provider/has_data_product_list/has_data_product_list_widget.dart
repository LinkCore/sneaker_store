import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/common/app_colors.dart';
import 'package:flutter_sneaker_store/common/app_textstyles.dart';

import '../../../../../core/user/roles.dart';
import '../../../../../generated/l10n.dart';
import '../../../../product/product_bloc/product_bloc.dart';
import '../../../../product/product_page/product_page.dart';

class HasDataProductListWidget extends StatefulWidget {
  final Roles? userRole;
  final ProductHasDataState state;

  const HasDataProductListWidget(
      {Key? key, required this.state, required this.userRole})
      : super(key: key);

  @override
  _HasDataProductListWidgetState createState() => _HasDataProductListWidgetState();
}

class _HasDataProductListWidgetState extends State<HasDataProductListWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
      sliver: SliverGrid.count(
        childAspectRatio: 1 / 1.2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: widget.state.productList.map((product) {
          return InkWell(
              child: Stack(
                children: [
                  Positioned(
                    child: Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: product.imagesUrls!.first,
                          placeholder: (context, string) =>
                              const CircularProgressIndicator(color: AppColors.primaryColor))))
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20)),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                '${product.productName} ',
                                style: AppTextStyles.gridCountModelTextStyle))
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              '${product.price.toString()} USD',
                              style: AppTextStyles.gridCountPriceTextStyle))])))]
              ),
              onLongPress: () async {
                if (widget.userRole == Roles.seller) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            title: Text(
                              S.current.deleteProduct,
                              style: AppTextStyles.plainTextStyle),
                            content: Text(
                              S.current.areYouSureYouWantToDeleteThisProduct,
                              style: AppTextStyles.plainTextStyle),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  context.read<ProductBloc>().add(
                                      DeleteProductEvent(product: product));
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  S.current.approve,
                                  style: AppTextStyles.alertApproveTextStyle),
                              )]
                          ));
                }},
              onTap: () async {
                Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProductPage(
                              product: product,
                              userRole: widget.userRole
                        )));
              });
        }).toList()));
  }
}