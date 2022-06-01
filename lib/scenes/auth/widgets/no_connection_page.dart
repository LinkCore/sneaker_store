import 'package:flutter/material.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_textstyles.dart';
import '../../../generated/l10n.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.backgroundColor.withOpacity(0.6),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const CircularProgressIndicator(color: AppColors.primaryColor),
          const SizedBox(width: 10),
          Center(
              child: Text(S.current.noInternetConnection,
                  style: AppTextStyles.noConnectionTextStyle))
        ]));
  }
}
