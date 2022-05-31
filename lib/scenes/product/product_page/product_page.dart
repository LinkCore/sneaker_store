import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/scenes/product/product_page/widgets/choose_size_text_widget.dart';
import 'package:flutter_sneaker_store/scenes/product/product_page/widgets/custom_dialog.dart';
import 'package:flutter_sneaker_store/scenes/product/product_page/widgets/main_image_widget.dart';
import 'package:flutter_sneaker_store/scenes/product/product_page/widgets/product_button_widget.dart';
import 'package:flutter_sneaker_store/scenes/product/product_page/widgets/product_info_widget.dart';
import 'package:flutter_sneaker_store/scenes/product/product_page/widgets/title_appbar_widget.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_textstyles.dart';
import '../../../core/product/product.dart';
import '../../../core/user/roles.dart';
import '../../../generated/l10n.dart';
import '../../cart/cart_bloc/cart_bloc.dart';
import '../../cart/cart_page.dart';

class ProductPage extends StatefulWidget {
  final Roles? userRole;
  final Product product;

  const ProductPage({Key? key, required this.product, required this.userRole})
      : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late TextEditingController productNameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late String imagePrevious = widget.product.imagesUrls!.first;

  int? sizePrevious;
  bool isTapped = false;
  int selectedImagesIndex = 0;
  int? selectedSizedIndex;
  Widget child = Container();

  @override
  void initState() {
    productNameController =
        TextEditingController(text: widget.product.productName);
    descriptionController =
        TextEditingController(text: widget.product.description);
    priceController =
        TextEditingController(text: widget.product.price.toString());
    child = Image.network(imagePrevious, key: const Key("init"));
    super.initState();
  }

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  List<Widget> _sizedList() {
    List<Widget> sizedWidgets = [];
    List<int>? sizedList = widget.product.sizedList;
    for (int i = 0; i < widget.product.sizedList!.length; i++) {
      sizedWidgets.add(InkWell(
          child: Container(
              height: MediaQuery.of(context).size.height / 16,
              width: MediaQuery.of(context).size.width / 8,
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: selectedSizedIndex == i
                          ? AppColors.primaryColor
                          : Colors.white70,
                      width: 2)),
              child: Center(
                  child: Text('${sizedList![i]}',
                      style: AppTextStyles.productModalTitleTextStyle))),
          onTap: () {
            setState(() {
              selectedSizedIndex = i;
            });
            setState(() {
              if (selectedSizedIndex == i) {
                sizePrevious = widget.product.sizedList![i];
              }
            });
          }));

      if (i != sizedList.length - 1) {
        sizedWidgets.add(const SizedBox(width: 10));
      }
    }
    return sizedWidgets;
  }

  List<Widget> _imagesList() {
    List<Widget> imageWidgets = [];
    List<String>? imagesList = widget.product.imagesUrls;
    for (int i = 0; i < widget.product.imagesUrls!.length; i++) {
      imageWidgets.add(InkWell(
          child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imagesList![i]),
                  ),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: selectedImagesIndex == i
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      width: 2.5))),
          onTap: () {
            setState(() {
              selectedImagesIndex = i;
            });
            if (selectedImagesIndex == i) {
              setState(() {
                imagePrevious = widget.product.imagesUrls![i];
              });
            } else {
              setState(() {
                imagePrevious = widget.product.imagesUrls!.first;
              });
            }
            setState(() {
              child = Image.network(imagePrevious, key: Key(i.toString()));
            });
          }));
    }
    return imageWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            title: TitleAppBarWidget(productName: productNameController.text),
            actions: [
              Visibility(
                  visible: widget.userRole == Roles.seller,
                  child: IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => CustomDialog(
                                product: widget.product,
                                selectedSize: widget.product.sizedList,
                                imagesList: widget.product.imagesUrls));
                      }))
            ]),
        body: Stack(children: [
          MainImageWidget(mainImage: child),
          Positioned.fill(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0))),
          Positioned(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: MediaQuery.of(context).size.height / 2.2,
                      decoration: const BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(35),
                              topLeft: Radius.circular(35))),
                      child: Column(children: [
                        ProductInfoWidget(
                            productName: productNameController.text,
                            description: descriptionController.text,
                            price: priceController.text),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: _imagesList())),
                        const ChooseSizeTextWidget(),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: _sizedList()))),
                        ProductButtonWidget(
                            isTapped: isTapped,
                            onTap: () async {
                              if (sizePrevious == null) {
                                ScaffoldMessenger.of(context)
                                    .removeCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(S.current.selectSize,
                                            style:
                                                AppTextStyles.plainTextStyle)));
                              } else {
                                if (!isTapped) {
                                  Product newProduct = Product(
                                      id: widget.product.id,
                                      productName: widget.product.productName,
                                      description: widget.product.description,
                                      price: widget.product.price,
                                      sizedList: [sizePrevious!],
                                      imagesUrls: widget.product.imagesUrls);
                                  context.read<CartBloc>().add(
                                      AddToCartEvent(newProduct: newProduct));
                                  setState(() {
                                    isTapped = true;
                                  });
                                } else {
                                  setState(() {
                                    isTapped = false;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CartPage()));
                                }
                              }
                            })
                      ]))))
        ]));
  }
}
