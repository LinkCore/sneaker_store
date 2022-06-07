import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_text_styles.dart';
import '../../../generated/l10n.dart';
import '../cart_bloc/cart_bloc.dart';

class CartButtonWidget extends StatefulWidget {
  final CartHasDataState state;

  const CartButtonWidget({Key? key, required this.state}) : super(key: key);

  @override
  State<CartButtonWidget> createState() => _CartButtonWidgetState();
}

class _CartButtonWidgetState extends State<CartButtonWidget> {
  void _alertDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: AppColors.backgroundColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            title: Text(S.current.buyingSuccess,
                style: AppTextStyles.buyingSuccessTextStyle),
            content: Text(S.current.haveAGoodDay,
                style: AppTextStyles.subMainTextStyle)));
    context.read<CartBloc>().add(ClearCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(35), topLeft: Radius.circular(35))),
        height: MediaQuery.of(context).size.height / 12.5,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text('\$ ${widget.state.totalCost.toString()}',
                          style: AppTextStyles.totalCostTextStyle)))),
          Expanded(
              child: InkWell(
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: MediaQuery.of(context).size.height / 17,
                      width: MediaQuery.of(context).size.height / 5,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: Text(S.current.buy,
                              style: AppTextStyles.buttonTextStyle))),
                  onTap: _alertDialog
                  ))
        ]));
  }
}