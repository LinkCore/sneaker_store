import 'package:flutter/material.dart';

class MainImageWidget extends StatefulWidget {
  final Widget mainImage;
  const MainImageWidget({Key? key, required this.mainImage}) : super(key: key);

  @override
  _MainImageWidgetState createState() => _MainImageWidgetState();
}

class _MainImageWidgetState extends State<MainImageWidget> {
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
