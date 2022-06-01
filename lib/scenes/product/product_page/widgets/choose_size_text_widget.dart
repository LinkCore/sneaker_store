import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/common/app_textstyles.dart';

import '../../../../generated/l10n.dart';

class ChooseSizeTextWidget extends StatelessWidget {
  const ChooseSizeTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 15),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(S.current.chooseYourSize,
                  style: AppTextStyles.productModalTitleTextStyle),
              Text(S.current.sizeGuide, style: AppTextStyles.sizeGuideTextStyle)
            ]));
  }
}
