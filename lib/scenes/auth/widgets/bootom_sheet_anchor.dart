import 'package:flutter/material.dart';

class ScrollIndicator extends StatelessWidget {
  final EdgeInsetsGeometry margin;

  const ScrollIndicator({Key? key, required this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        width: MediaQuery.of(context).size.width,
        height: 6,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)));
  }
}
