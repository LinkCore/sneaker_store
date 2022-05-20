import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/scenes/product/product_bloc/product_bloc.dart';
import 'package:flutter_sneaker_store/scenes/product/widgets/choose_size.dart';
import 'package:flutter_sneaker_store/scenes/product/widgets/image_previous.dart';
import 'package:flutter_sneaker_store/scenes/product/widgets/modal_textfield.dart';
import 'package:flutter_sneaker_store/scenes/product/widgets/modal_title.dart';
import 'package:flutter_sneaker_store/scenes/product/widgets/select_photos.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string_generator/random_string_generator.dart';

import '../../common/app_colors.dart';
import '../../common/app_utilities.dart';
import '../../core/product/product.dart';
import '../../generated/l10n.dart';

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

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(35), topLeft: Radius.circular(35)),
              color: AppColors.backgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 110),
                  width: MediaQuery.of(context).size.width,
                  height: 6,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(5)),
                ),
                ModalTitle(titleText: S.current.addYourMagicalProduct),
                ModalTextField(
                  labelText: S.current.brandModel,
                  controller: productNameController,
                  keyboardType: TextInputType.text,
                ),
                ModalTextField(
                  labelText: S.current.shortDescription,
                  controller: descriptionController,
                  keyboardType: TextInputType.text,
                ),
                ModalTextField(
                  labelText: S.current.price,
                  controller: priceController,
                  keyboardType: TextInputType.phone,
                ),
                ChooseSize(selectedIndex: selectedIndex),
                Builder(builder: (context) {
                  if (selectedPictures.isEmpty) {
                    return SelectPhotos(
                      onTap:
                          (List<FileImage> indexes, List<File> picturesFile) {
                        setState(() {
                          selectedPicturesBase64 = picturesFile;
                          selectedPictures = indexes;
                        });
                      },
                    );
                  } else {
                    return ImagePrevious(allPicture: selectedPictures);
                  }
                }),
                const Spacer(),
                InkResponse(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width / 1,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        S.current.addProduct,
                        style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  onTap: () async {

                    List<int> sizedList = [];
                    for (var element in selectedIndex) {
                      sizedList.add(AppUtilities.sizeList[element]);
                    }

                    Product newProduct = Product(
                      id: RandomStringGenerator(
                              fixedLength: 10, hasSymbols: false)
                          .generate(),
                      productName: productNameController.text,
                      description: descriptionController.text,
                      price: double.parse(priceController.text),
                      sizedList: sizedList,
                      imagesList: selectedPicturesBase64,
                    );

                    context.read<ProductBloc>().add(AddProductEvent(product: newProduct));
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
      },
      expand: false,
      initialChildSize: 0.66,
    );
  }
}
