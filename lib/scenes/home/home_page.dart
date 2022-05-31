import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/scenes/home/widgets/brand_filter_widget.dart';
import 'package:flutter_sneaker_store/scenes/home/widgets/home_page_button_widget.dart';
import 'package:flutter_sneaker_store/scenes/home/widgets/home_page_header_widget.dart';
import 'package:flutter_sneaker_store/scenes/home/widgets/product_list_provider/product_list_provider_widget.dart';

import '../../core/user/roles.dart';
import '../cart/cart_page.dart';
import '../product/add_product/add_product_modal.dart';

class HomePage extends StatefulWidget {
  final Roles? userRoles;

  const HomePage({Key? key, required this.userRoles}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void goToCart() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CartPage()));
  }

  void addProduct() {
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        context: context,
        builder: (context) {
          return const AddProductModal();
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const HomePageHeaderWidget(),
                  const BrandFilterWidget(),
                  ProductListProviderWidget(userRole: widget.userRoles)
                ])),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          HomePageButtonWidget(
              heroTag: 'Cart', icon: Icons.shopping_cart, onPressed: goToCart),
          Visibility(
              visible: widget.userRoles == Roles.seller,
              child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: HomePageButtonWidget(
                      heroTag: 'Add Product',
                      icon: Icons.add,
                      onPressed: addProduct)))
        ]));
  }
}
