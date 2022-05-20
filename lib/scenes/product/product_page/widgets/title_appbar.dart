import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleAppBar extends StatelessWidget {
  final String productName;
  const TitleAppBar({Key? key, required this.productName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Text(
        productName,
        style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w800),
      ),
    );
  }
}
