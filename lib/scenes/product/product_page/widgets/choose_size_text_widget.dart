import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../generated/l10n.dart';

class ChooseSizeText extends StatelessWidget {
  const ChooseSizeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: 40, right: 40, top: 10, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              S.current.chooseYourSize,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300)),
          Text(
              S.current.sizeGuide,
              style: GoogleFonts.poppins(
                  color: Colors.white54,
                  fontSize: 16,
                  fontWeight: FontWeight.w300))
        ],
      ),
    );
  }
}
