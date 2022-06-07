import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/common/app_text_styles.dart';
import 'package:flutter_sneaker_store/scenes/cart/widgets/cart_button_widget.dart';
import 'package:flutter_sneaker_store/scenes/cart/widgets/cart_product_widget.dart';
import 'package:flutter_sneaker_store/scenes/cart/widgets/empty_cart_widget.dart';

import '../../common/app_colors.dart';
import '../../generated/l10n.dart';
import 'cart_bloc/cart_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
            centerTitle: true,
            title: Text(S.current.yourCart,
                style: AppTextStyles.yourCartTextStyle),
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            actions: [
              IconButton(
                  icon: Icon(Icons.delete,
                      color: Colors.redAccent.withOpacity(0.9)),
                  onPressed: () =>
                    context.read<CartBloc>().add(ClearCartEvent())
                  )
            ]),
        body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator(
              color: AppColors.primaryColor,
            );
          } else if (state is CartHasDataState) {
            if (state.productList.isEmpty) {
              return const EmptyCartWidget();
            } else {
              return Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Positioned(
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: CartProductWidget(state: state))),
                    Positioned(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: CartButtonWidget(state: state)))
                  ]);
            }
          } else {
            return const EmptyCartWidget();
          }
        }));
  }
}