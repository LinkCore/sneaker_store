import 'package:flutter/material.dart';

class MainImage extends StatefulWidget {
  final Widget mainImage;
  const MainImage({Key? key, required this.mainImage}) : super(key: key);

  @override
  _MainImageState createState() => _MainImageState();
}

class _MainImageState extends State<MainImage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.height,
      height: MediaQuery.of(context).size.height / 2.2,
      child: FittedBox(
        fit: BoxFit.cover,
        child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: widget.mainImage,
        ),
      ),
    );
  }
}
