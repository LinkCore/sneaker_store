import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/common/app_textstyles.dart';

class ProductInfoWidget extends StatelessWidget {
  final String productName;
  final String description;
  final String price;

  const ProductInfoWidget(
      {Key? key,
      required this.productName,
      required this.description,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 10),
        child: Row(children: [
          Expanded(
              flex: 9,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(productName,
                            style: AppTextStyles.cartIsEmptyTextStyle)),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(description,
                            style: AppTextStyles.sizeGuideTextStyle))
                  ])),
          const Spacer(),
          Expanded(
              flex: 4,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text("\$ $price",
                          style: AppTextStyles.priceTextStyle))))
        ]));
  }
}
