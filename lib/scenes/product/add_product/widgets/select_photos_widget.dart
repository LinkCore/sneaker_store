import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../generated/l10n.dart';
import '../../../gallery/gallery_page.dart';


class SelectPhotosWidget extends StatefulWidget {
  final Function onTap;

  const SelectPhotosWidget({Key? key, required this.onTap})
      : super(key: key);

  @override
  _SelectPhotosWidgetState createState() => _SelectPhotosWidgetState();
}

class _SelectPhotosWidgetState extends State<SelectPhotosWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: MediaQuery.of(context).size.height / 22.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            S.current.selectPhotos,
            style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            useRootNavigator: true,
            context: context,
            builder: (context) {
              return GalleryPage(indexes: widget.onTap);
            },
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35)),
            ));
      },
    );
  }
}
