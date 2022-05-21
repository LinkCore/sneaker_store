import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/scenes/home/widgets/home_page_button_widget.dart';
import 'package:flutter_sneaker_store/scenes/home/widgets/sliver_bloc_consumer/sliver_bloc_consumer_widget.dart';
import 'package:flutter_sneaker_store/scenes/home/widgets/sliver_brand_filter_widget.dart';
import 'package:flutter_sneaker_store/scenes/home/widgets/sliver_header_widget.dart';

import '../product/add_product/add_product_modal.dart';
import '../cart/cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void goToCart(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const CartPage()));
  }

  void addProduct(){
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        context: context,
        builder: (context) {
          return const AddProductModal();
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: const CustomScrollView(
        physics: BouncingScrollPhysics(),
          slivers: [
        SliverHeaderWidget(),
        SliverBrandFilterWidget(),
        SliverBlocConsumerWidget(),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          HomePageButtonWidget(
            heroTag: 'Cart',
            icon: Icons.shopping_cart,
            onPressed: goToCart,
          ),
          const SizedBox(height: 5),
          HomePageButtonWidget(
            heroTag: 'Add Product',
            icon: Icons.add,
            onPressed: addProduct,
          ),
        ],
      ),
    );
  }
}
