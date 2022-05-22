import 'package:flutter/material.dart';

class BottomSheetAnchor extends StatelessWidget {
  final EdgeInsetsGeometry margin;

  const BottomSheetAnchor({Key? key, required this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: MediaQuery.of(context).size.width,
      height: 6,
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
