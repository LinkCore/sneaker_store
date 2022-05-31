import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/common/app_colors.dart';

import '../../../common/app_textstyles.dart';
import '../../../core/product/product.dart';
import '../../../generated/l10n.dart';
import '../../auth/auth_bloc/auth_bloc.dart';
import '../../product/product_bloc/product_bloc.dart';

class HomePageHeaderWidget extends StatefulWidget {
  const HomePageHeaderWidget({Key? key}) : super(key: key);

  @override
  _HomePageHeaderWidgetState createState() => _HomePageHeaderWidgetState();
}

class _HomePageHeaderWidgetState extends State<HomePageHeaderWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      expandedHeight: MediaQuery.of(context).size.height / 8.5,
      collapsedHeight: MediaQuery.of(context).size.height / 8.5,
      flexibleSpace: Container(

          margin: const EdgeInsets.only(top: 60, left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width/1.2,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.white70,),
                    labelStyle: AppTextStyles.labelTextStyle,
                    contentPadding: const EdgeInsets.only(right: 20),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white70, width: 2),  borderRadius:  BorderRadius.all(Radius.circular(15)),),
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white70, width: 2),  borderRadius:  BorderRadius.all(Radius.circular(15)),),
                    border: InputBorder.none,
                    hintText: S.current.search,
                  ),
                  style: AppTextStyles.labelTextStyle,
                  controller: searchController,
                  onChanged: (value) {

                    context.read<ProductBloc>().add(
                      OnStartupEvent(
                        isUpdate: false,
                        filter: Brands.noFilter,
                        searchFilter: searchController.text
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                  child: const Icon(
                    Icons.login,
                    color: Colors.white70,
                  ),
                  onTap:(){
                    context.read<AuthBloc>().add(SignOutEvent());
                    }
                  ),
            ],
          )
      ),
    );
  }
}
