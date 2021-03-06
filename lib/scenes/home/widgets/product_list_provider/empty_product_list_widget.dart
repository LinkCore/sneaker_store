import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/common/app_text_styles.dart';

import '../../../../generated/l10n.dart';

class EmptyProductListWidget extends StatelessWidget {
  const EmptyProductListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
            child: Center(
                child: Text(S.current.noSelectedProducts,
                    style: AppTextStyles.backgroundRolesSwitcherTextStyle))));
  }
}