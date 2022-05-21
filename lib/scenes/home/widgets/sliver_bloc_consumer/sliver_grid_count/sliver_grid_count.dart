import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/common/app_textstyles.dart';

import '../../../../../generated/l10n.dart';
import '../../../../product/product_bloc/product_bloc.dart';
import '../../../../product/product_page/product_page.dart';

class SliverGridCount extends StatefulWidget {
  final ProductHasDataState state;

  const SliverGridCount({Key? key, required this.state}) : super(key: key);

  @override
  _SliverGridCountState createState() => _SliverGridCountState();
}

class _SliverGridCountState extends State<SliverGridCount> {

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
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      product.imagesUrls!.first,
                    ),
                    alignment: Alignment.topCenter,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child:
                  Column(mainAxisSize: MainAxisSize.min,
                      children: [
                        SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('${product.productName} ',
                            style: AppTextStyles.gridCountModelTextStyle,
                        ),
                      ),
                    ),
                    Text(
                      '${product.price.toString()} USD',
                      style: AppTextStyles.gridCountPriceTextStyle,
                      ),
                    ],
                  ),
                ),
              ),


              onLongPress: () async {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      title: Text(
                        S.current.deleteProduct,
                        style: AppTextStyles.labelTextStyle,
                      ),
                      content: Text(
                        S.current.areYouSureYouWantToDeleteThisProduct,
                        style: AppTextStyles.labelTextStyle,
                      ),
                      actions: [
                        TextButton(
                          onPressed: (){
                            context.read<ProductBloc>().add(DeleteProductEvent(product: product));
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            S.current.approve,
                            style: AppTextStyles.alertApproveTextStyle,
                          ),
                        )
                      ],
                    ));
              },

              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductPage(product: product)
                      )
                  );
                }
              );
          }
        ).toList(),
      ),
    );
  }
}
