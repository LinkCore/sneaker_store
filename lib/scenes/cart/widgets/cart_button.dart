import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/app_colors.dart';
import '../../../generated/l10n.dart';
import '../cart_bloc/cart_bloc.dart';

class CartButton extends StatefulWidget {
  final CartHasDataState state;
  const CartButton({Key? key, required this.state}) : super(key: key);

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(35),
            topLeft: Radius.circular(35),
          )),
      height: MediaQuery.of(context).size.height / 12.5,
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceAround,
        children: [
          Text(
            '\$ ${widget.state.totalCost.toString()}',
            style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          InkWell(
            child: Container(
              height:
              MediaQuery.of(context).size.height /
                  17,
              width:
              MediaQuery.of(context).size.height /
                  5,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius:
                  BorderRadius.circular(15)),
              child: Center(
                  child: Text(
                    S.current.buy,
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.w600),
                  )),
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor:
                    AppColors.backgroundColor,
                    shape:
                    const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(
                            Radius.circular(
                                15.0))),
                    title: Text(
                      S.current.buyingSuccess,
                      style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight:
                          FontWeight.w500),
                    ),
                    content: Text(
                      S.current.haveAGoodDay,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight:
                          FontWeight.w300),
                    ),
                  ));

              context.read<CartBloc>().add(ClearCartEvent());

            },
          )
        ],
      ),
    );
  }
}
