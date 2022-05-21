import 'package:flutter/material.dart';

class HomePageButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String heroTag;
  final IconData icon;

  const HomePageButton(
      {Key? key,
      required this.onPressed,
      required this.heroTag,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: onPressed,
      backgroundColor: Colors.amber,
      child: Icon(icon, size: 26),
    );
  }
}
