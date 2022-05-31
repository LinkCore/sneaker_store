import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/common/app_textstyles.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/app_brand_image.dart';
import '../../../common/app_colors.dart';
import '../../../core/product/product.dart';
import '../../../generated/l10n.dart';
import '../../product/product_bloc/product_bloc.dart';

class BrandFilterWidget extends StatefulWidget {
  const BrandFilterWidget({Key? key}) : super(key: key);

  @override
  _BrandFilterWidgetState createState() => _BrandFilterWidgetState();
}

class _BrandFilterWidgetState extends State<BrandFilterWidget> {

  Brands brandsFilter = Brands.noFilter;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, bottom: 10),
                child: Text(
                  S.current.shopByBrand,
                  style: AppTextStyles.brandFilterTextStyle,
                ),
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.only(right: 15, bottom: 10),
                  child: Text(
                    S.current.showAll,
                    style: GoogleFonts.poppins(color:  brandsFilter == Brands.noFilter ? Colors.white54 : Colors.amber,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                onTap: (){
                  setState(() {
                    brandsFilter = Brands.noFilter;
                  });
                  context.read<ProductBloc>().add(
                    OnStartupEvent(
                        isUpdate: false,
                        filter: Brands.noFilter,
                        searchFilter: ''
                    ),
                  );
                },
              ),
            ],
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
                          border: Border.all(color: brandsFilter == element.brandsName ? Colors.amber : Colors.transparent, width: 2.5)
                        ),
                        child: Image.asset(
                          element.asset,
                          width: 80,
                          height: 60,
                        )),
                    onTap: () {
                      setState(() {
                        brandsFilter = element.brandsName;
                      });
                      if(brandsFilter == element.brandsName){
                        context.read<ProductBloc>().add(
                          OnStartupEvent(
                              isUpdate: false,
                              filter: element.brandsName,
                              searchFilter: ''
                          ),
                        );
                      }
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
