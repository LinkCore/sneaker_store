import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_utilities.dart';
import '../../../../core/product/product.dart';
import '../../../../core/product/product_repository.dart';
import '../../../../generated/l10n.dart';
import '../../add_product/widgets/choose_size_widget.dart';
import '../../add_product/widgets/image_previous_widget.dart';
import '../../add_product/widgets/modal_textfield_widget.dart';
import '../../add_product/widgets/select_photos_widget.dart';
import '../../product_bloc/product_bloc.dart';

class CustomDialog extends StatefulWidget {

  final Product product;

  const CustomDialog({Key? key, required this.product}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {

  late TextEditingController productNameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late String imagePrevious = widget.product.imagesUrls!.first;
  List<int> selectedIndex = [];
  List<File> selectedPicturesBase64 = [];
  late List<FileImage> selectedPictures;

  @override
  void initState() {
    selectedPictures = [];
    productNameController =
        TextEditingController(text: widget.product.productName);
    descriptionController =
        TextEditingController(text: widget.product.description);
    priceController =
        TextEditingController(text: widget.product.price.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 3.0,
        sigmaY: 3.0,
      ),
      child: AlertDialog(
        scrollable: true,
        backgroundColor:
        AppColors.backgroundColor.withOpacity(0.5),
        shape: const RoundedRectangleBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(20.0))),
        title: Center(
          child: Text(
            "Edit ${productNameController.text}",
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800),
          ),
        ),
        actions: [
          ModalTextFieldWidget(
              labelText: S.current.brandModel,
              controller: productNameController,
              keyboardType: TextInputType.text,
              filteringText: const []),
          ModalTextFieldWidget(
            labelText: S.current.shortDescription,
            controller: descriptionController,
            keyboardType: TextInputType.text,
            filteringText: const [],
          ),
          ModalTextFieldWidget(
            labelText: S.current.price,
            controller: priceController,
            keyboardType: TextInputType.phone,
            filteringText: [
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          ChooseSizeWidget(selectedIndex: selectedIndex),
          Builder(builder: (context) {
            if (selectedPictures.isEmpty) {
              return SelectPhotosWidget(
                onTap:
                    (List<FileImage> indexes, List<File> picturesFile) {
                  setState(() {
                    selectedPicturesBase64 = picturesFile;
                    selectedPictures = indexes;
                  });
                },
              );
            } else {
              return ImagePreviousWidget(allPicture: selectedPictures);
            }
          }),
          TextButton(
            onPressed: () async {
              List<int> sizedList = [];
              for (var element in selectedIndex) {
                sizedList.add(AppUtilities.sizeList[element]);
              }

              Product newProduct = Product(
                id: widget.product.id,
                productName: productNameController.text,
                description: descriptionController.text,
                price: double.parse(priceController.text),
                sizedList: sizedList,
                imagesUrls: await ProductRepository().uploadImages(selectedPicturesBase64, widget.product.id!),
              );

              context
                  .read<ProductBloc>()
                  .add(EditProductEvent(product: newProduct));
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(
              "Apply",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.amber, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
