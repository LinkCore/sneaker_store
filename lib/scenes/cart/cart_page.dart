import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/scenes/cart/widgets/cart_button.dart';
import 'package:flutter_sneaker_store/scenes/cart/widgets/cart_product.dart';
import 'package:flutter_sneaker_store/scenes/cart/widgets/empty_cart.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/app_colors.dart';
import '../../generated/l10n.dart';
import 'cart_bloc/cart_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalCost = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            S.current.yourCart,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
          ),
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent.withOpacity(0.9),
              ),
              onPressed: () {
                context.read<CartBloc>().add(ClearCartEvent());
              },
            )
          ],
        ),
        body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          } else if (state is CartHasDataState) {
            if (state.productList.isEmpty) {
              return const EmptyCart();
            } else {
              return Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Positioned(
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: CartProduct(state: state),
                        )
                    ),
                    Positioned(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: CartButton(state: state)))
                  ]);
            }
          } else {
            return const EmptyCart();
          }
        }));
  }
}
