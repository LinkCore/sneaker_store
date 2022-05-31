import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiblock/uiblock.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_textstyles.dart';
import '../../../../common/app_utilities.dart';
import '../../../../core/product/product.dart';
import '../../../../core/product/product_repository.dart';
import '../../../../generated/l10n.dart';
import '../../add_product/widgets/image_previous_widget.dart';
import '../../add_product/widgets/modal_textfield_widget.dart';
import '../../add_product/widgets/select_photos_widget.dart';
import '../../product_bloc/product_bloc.dart';

class CustomDialog extends StatefulWidget {
  final Product product;
  final List<int>? selectedSize;
  final List<String>? imagesList;

  const CustomDialog(
      {Key? key,
      required this.product,
      required this.selectedSize,
      required this.imagesList})
      : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  late TextEditingController productNameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  List<File> selectedPicturesBase64 = [];
  late List<FileImage> selectedPictures = [];

  List<Widget> _editListSize() {
    List<Widget> widgets = [];
    List<int> sizedList = AppUtilities.sizeList;
    for (int i = 0; i < AppUtilities.sizeList.length; i++) {
      widgets.add(InkWell(
          child: Container(
              height: MediaQuery.of(context).size.height / 16,
              width: MediaQuery.of(context).size.width / 8,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: widget.selectedSize!.contains(sizedList[i])
                          ? Colors.amber
                          : Colors.white70,
                      width: 2)),
              child: Center(
                  child: Text('${sizedList[i]}',
                      style: AppTextStyles.productModalTitleTextStyle))),
          onTap: () {
            if (widget.selectedSize!.contains(sizedList[i])) {
              setState(() {
                widget.selectedSize!.remove(sizedList[i]);
              });
            } else {
              setState(() {
                widget.selectedSize!.add(sizedList[i]);
              });
            }
          }));
      if (i != sizedList.length - 1) {
        widgets.add(const SizedBox(width: 5));
      }
    }
    return widgets;
  }

  List<Widget> _imagesList() {
    List<Widget> imageWidgets = [];
    if (selectedPictures.isEmpty) {
      for (int i = 0; i < widget.product.imagesUrls!.length; i++) {
        imageWidgets.add(InkWell(
            child: FittedBox(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.product.imagesUrls![i])),
                        borderRadius: BorderRadius.circular(15))))));
      }
    } else {
      imageWidgets.add(ImagePreviousWidget(allPicture: selectedPictures));
    }
    return imageWidgets;
  }

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
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: AlertDialog(
            scrollable: true,
            backgroundColor: AppColors.backgroundColor.withOpacity(0.5),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Center(
                child: Text('${S.current.edit} ${productNameController.text}',
                    style: AppTextStyles.editProductNameTextStyle)),
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
                  filteringText: const []),
              ModalTextFieldWidget(
                  labelText: S.current.price,
                  controller: priceController,
                  keyboardType: TextInputType.phone,
                  filteringText: [FilteringTextInputFormatter.digitsOnly]),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: _editListSize())),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _imagesList())),
              Container(
                  margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                  child: SelectPhotosWidget(onTap:
                      (List<FileImage> indexes, List<File> picturesFile) {
                    setState(() {
                      selectedPictures.clear();
                      selectedPicturesBase64 = picturesFile;
                      selectedPictures = indexes;
                    });
                  })),
              TextButton(
                  onPressed: () async {
                    UIBlock.block(context,
                        customLoaderChild: const CircularProgressIndicator(
                            color: AppColors.primaryColor));
                    Product newProduct = Product(
                        id: widget.product.id,
                        productName: productNameController.text,
                        description: descriptionController.text,
                        price: double.parse(priceController.text),
                        sizedList: widget.selectedSize,
                        imagesUrls: await ProductRepository().uploadImages(
                            widget.product.id!,
                            oldFiles: widget.imagesList!,
                            newFiles: selectedPicturesBase64));
                    UIBlock.unblock(context);
                    context
                        .read<ProductBloc>()
                        .add(EditProductEvent(product: newProduct));
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text(S.current.apply,
                      style: AppTextStyles.applyTextStyle))
            ]));
  }
}
