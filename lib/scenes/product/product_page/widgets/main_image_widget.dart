import 'package:flutter/material.dart';

class MainImageWidget extends StatelessWidget {
  final Widget mainImage;

  const MainImageWidget({Key? key, required this.mainImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.height,
        height: MediaQuery.of(context).size.height / 2.2,
        child: FittedBox(
            fit: BoxFit.cover,
            child: AnimatedSwitcher(
                duration: const Duration(seconds: 1), child: mainImage)));
  }
}