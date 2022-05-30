import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/app_colors.dart';
import '../../generated/l10n.dart';

class NoConnectionPage extends StatefulWidget {
  const NoConnectionPage({Key? key}) : super(key: key);

  @override
  _NoConnectionPageState createState() => _NoConnectionPageState();
}

class _NoConnectionPageState extends State<NoConnectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor.withOpacity(0.5),
      body: Center(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Colors.amber),
          const SizedBox(width: 10),
          Text(S.current.noInternetConnection, style: GoogleFonts.poppins()),
        ],
      ),),
    );
  }
}
