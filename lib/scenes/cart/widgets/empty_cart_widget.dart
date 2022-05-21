import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/app_colors.dart';
import '../../../generated/l10n.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                color: Colors.amber,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.cartIsEmpty,
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    S.current.pleaseAddedSomeProducts,
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
