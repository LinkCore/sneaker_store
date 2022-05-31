import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/common/app_textstyles.dart';

import '../../../common/app_colors.dart';
import '../../../generated/l10n.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.backgroundColor,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const CircularProgressIndicator(color: AppColors.primaryColor),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(S.current.cartIsEmpty,
                  style: AppTextStyles.cartIsEmptyTextStyle),
              Text(S.current.pleaseAddedSomeProducts,
                  style: AppTextStyles.pleaseAddedSomeProductsTextStyle)
            ])
          ])
        ]));
  }
}
