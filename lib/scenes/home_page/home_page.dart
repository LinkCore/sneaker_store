import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/scenes/home_page/widgets/home_page_button.dart';
import 'package:flutter_sneaker_store/scenes/home_page/widgets/sliver_bloc_consumer/sliver_bloc_consumer.dart';
import 'package:flutter_sneaker_store/scenes/home_page/widgets/sliver_brand_filter.dart';
import 'package:flutter_sneaker_store/scenes/home_page/widgets/sliver_header.dart';

import '../product/add_product_modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
        SliverHeader(),
        SliverBrandFilter(),
        SliverBlocConsumer(),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          HomePageButton(
            heroTag: 'Cart',
            icon: Icons.shopping_cart,
            onPressed: (){

              /// function to go to the cart

            },
          ),
          const SizedBox(height: 5),
          HomePageButton(
            heroTag: 'Add Product',
            icon: Icons.add,
            onPressed: addProduct,
          ),
        ],
      ),
    );
  }
}
