import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/common/app_textstyles.dart';

import '../../../common/app_brand_image.dart';
import '../../../common/app_colors.dart';
import '../../../generated/l10n.dart';
import '../../product/product_bloc/product_bloc.dart';

class SliverBrandFilter extends StatefulWidget {
  const SliverBrandFilter({Key? key}) : super(key: key);

  @override
  _SliverBrandFilterState createState() => _SliverBrandFilterState();
}

class _SliverBrandFilterState extends State<SliverBrandFilter> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      expandedHeight: MediaQuery.of(context).size.height / 7,
      collapsedHeight: MediaQuery.of(context).size.height / 7,
      flexibleSpace: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15, bottom: 10),
            child: Text(
              S.current.shopByBrand,
              style: AppTextStyles.brandFilterTextStyle,
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(right: 10),
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Row(
                  children: brandImage
                      .map((element) => InkWell(
                    child: Container(
                        margin: const EdgeInsets.only(
                            left: 15, bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(
                          element.asset,
                          width: 80,
                          height: 60,
                        )),
                    onTap: () {
                      context.read<ProductBloc>().add(
                        OnStartupEvent(
                            isUpdate: false,
                            filter: element.brandsName,
                            searchFilter: ''
                        ),
                      );

                    },
                  ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
