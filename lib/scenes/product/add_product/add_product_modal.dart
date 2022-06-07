import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/scenes/auth/widgets/auth_button_widget.dart';
import 'package:flutter_sneaker_store/scenes/product/product_bloc/product_bloc.dart';
import 'package:random_string_generator/random_string_generator.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_text_styles.dart';
import '../../../common/app_utilities.dart';
import '../../../core/product/product.dart';
import '../../../generated/l10n.dart';
import '../../auth/widgets/bootom_sheet_anchor.dart';
import 'widgets/choose_size_widget.dart';
import 'widgets/image_previous_widget.dart';
import 'widgets/modal_textfield_widget.dart';
import 'widgets/select_photos_widget.dart';

class AddProductModal extends StatefulWidget {
  const AddProductModal({
    Key? key,
  }) : super(key: key);

  @override
  State<AddProductModal> createState() => _AddProductModalState();
}

class _AddProductModalState extends State<AddProductModal> {
  late TextEditingController productNameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  List<int> selectedIndex = [];
  List<File> selectedPicturesBase64 = [];
  late List<FileImage> selectedPictures;

  @override
  void initState() {
    super.initState();
    selectedPictures = [];
    productNameController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
  }

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Future<void> _addProduct() async {
    List<int> sizedList = [];
    for (var element in selectedIndex) {
      sizedList.add(AppUtilities.sizeList[element]);
    }

    Product newProduct = Product(
        id: RandomStringGenerator(fixedLength: 10, hasSymbols: false)
            .generate(),
        productName: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        sizedList: sizedList,
        imagesList: selectedPicturesBase64);

    context.read<ProductBloc>().add(AddProductEvent(product: newProduct));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(35),
                      topLeft: Radius.circular(35)),
                  color: AppColors.backgroundColor),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ScrollIndicator(
                        margin:
                            EdgeInsets.only(left: 140, right: 140, bottom: 10)),
                    Container(
                        margin: const EdgeInsets.only(bottom: 40, top: 5),
                        child: Text(S.current.addYourMagicalProduct,
                            style: AppTextStyles.productModalTitleTextStyle)),
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
                        filteringText: [
                          FilteringTextInputFormatter.digitsOnly
                        ]),
                    ChooseSizeWidget(selectedIndex: selectedIndex),
                    Builder(builder: (context) {
                      if (selectedPictures.isEmpty) {
                        return SelectPhotosWidget(onTap:
                            (List<FileImage> indexes, List<File> picturesFile) {
                          setState(() {
                            selectedPicturesBase64 = picturesFile;
                            selectedPictures = indexes;
                          });
                        });
                      } else {
                        return ImagePreviousWidget(
                            allPicture: selectedPictures);
                      }
                    }),
                    const Spacer(),
                    CommonTextButtonWidget(
                        margin: const EdgeInsets.only(top: 0),
                        text: S.current.addProduct,
                        onTap: _addProduct)
                  ]));
        },
        expand: false,
        initialChildSize: 0.66);
  }
}