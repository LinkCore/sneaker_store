import 'package:flutter/material.dart';

class ImagePreviousWidget extends StatelessWidget {
  final List<FileImage> allPicture;

  const ImagePreviousWidget({Key? key, required this.allPicture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      for (var image in allPicture)
        Container(
            height: MediaQuery.of(context).size.height / 15,
            width: MediaQuery.of(context).size.width / 5.5,
            decoration: BoxDecoration(
                image: DecorationImage(image: image, fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(15)))
    ]);
  }
}
