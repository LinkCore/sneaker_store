import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/scenes/product/product_page/widgets/choose_size_text.dart';
import 'package:flutter_sneaker_store/scenes/product/product_page/widgets/main_image.dart';
import 'package:flutter_sneaker_store/scenes/product/product_page/widgets/main_text.dart';
import 'package:flutter_sneaker_store/scenes/product/product_page/widgets/product_button.dart';
import 'package:flutter_sneaker_store/scenes/product/product_page/widgets/title_appbar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/app_colors.dart';
import '../../../core/product/product.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({Key? key, required this.product}) : super(key: key);

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
                  color:
                      selectedSizedIndex == i ? Colors.amber : Colors.white70,
                  width: 2)),
          child: Center(
            child: Text(
              '${sizedList![i]}',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w300),
            ),
          ),
        ),
        onTap: () {
          setState(() {
            selectedSizedIndex = i;
          });
          setState(() {
            if (selectedSizedIndex == i) {
              sizePrevious = widget.product.sizedList![i];
            }
          });
        },
      ));

      if (i != sizedList.length - 1) {
        sizedWidgets.add(const SizedBox(
          width: 10,
        ));
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
                      ? Colors.amber
                      : Colors.transparent,
                  width: 2.5)),
        ),
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
        },
      ));
    }
    return imageWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: TitleAppBar(productName: productNameController.text),
      ),
      body: Stack(
        children: [
          MainImage(mainImage: child),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height / 2.2,
                decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(35),
                      topLeft: Radius.circular(35)),
                ),
                child: Column(
                  children: [
                    MainText(
                        productName: productNameController.text,
                        description: descriptionController.text,
                        price: priceController.text
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _imagesList(),
                      ),
                    ),
                    const ChooseSizeText(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: _sizedList(),
                        ),
                      ),
                    ),
                    ProductButton(
                      isTapped: isTapped,
                      onTap: () async {
                        if (sizePrevious == null) {
                          ScaffoldMessenger.of(context)
                              .removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Select size')));
                        } else {
                          if (!isTapped) {
                            Product newProduct = Product(
                              id: widget.product.id,
                              productName: widget.product.productName,
                              description: widget.product.description,
                              price: widget.product.price,
                              sizedList: [sizePrevious!],
                              imagesUrls: widget.product.imagesUrls,
                            );

                            /// add product to cart

                            setState(() {
                              isTapped = true;
                            });
                          } else {

                            /// go to cart

                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}