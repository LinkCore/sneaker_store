import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/app_textstyles.dart';
import '../../../../core/user/roles.dart';
import '../../../../generated/l10n.dart';
import '../../../product/product_bloc/product_bloc.dart';
import 'empty_product_list_widget.dart';
import 'error_text_widget.dart';
import 'has_data_product_list/has_data_product_list_widget.dart';
import 'loading_widget.dart';

class ProductListProviderWidget extends StatefulWidget {
  final Roles? userRole;

  const ProductListProviderWidget({Key? key, required this.userRole})
      : super(key: key);

  @override
  _ProductListProviderWidgetState createState() =>
      _ProductListProviderWidgetState();
}

class _ProductListProviderWidgetState extends State<ProductListProviderWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
        listener: (BuildContext context, state) {
      if (state is ProductHasDataState) {
        if (state.isUpdate) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(S.current.dataUpdated,
                  style: AppTextStyles.plainTextStyle)));
        }
      }
    }, builder: (context, state) {
      if (state is LoadingState) {
        return const LoadingWidget();
      }
      if (state is ProductHasDataState) {
        if (state.productList.isEmpty) {
          return const EmptyProductListWidget();
        } else {
          return HasDataProductListWidget(
              state: state, userRole: widget.userRole);
        }
      }
      if (state is ErrorState) {
        return ErrorTextWidget(text: '${S.current.error}' '${state.errorText}');
      } else {
        return ErrorTextWidget(text: S.current.error);
      }
    });
  }
}
