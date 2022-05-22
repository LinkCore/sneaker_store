import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/app_textstyles.dart';
import '../../../../generated/l10n.dart';
import '../../../home/widgets/sliver_bloc_consumer/sliver_grid_count/sliver_grid_count_widget.dart';
import '../../../product/product_bloc/product_bloc.dart';
import 'circular_loading_widget.dart';
import 'empty_product_list_widget.dart';
import 'error_text_widget.dart';

class SliverBlocConsumerWidget extends StatefulWidget {
  const SliverBlocConsumerWidget({Key? key}) : super(key: key);

  @override
  _SliverBlocConsumerWidgetState createState() => _SliverBlocConsumerWidgetState();
}

class _SliverBlocConsumerWidgetState extends State<SliverBlocConsumerWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (BuildContext context, state) {
        if (state is ProductHasDataState) {
          if (state.isUpdate) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(S.current.dataUpdated, style: AppTextStyles.labelTextStyle,)));
          }
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return const CircularLoadingWidget();
        }
        if (state is ProductHasDataState) {
          if(state.productList.isEmpty){
            return const EmptyProductListWidget();
          }
          else{
            return SliverGridCountWidget(state: state);
          }
        }
        if (state is ErrorState) {
          return ErrorTextWidget(text: '${S.current.error}' '${state.errorText}');
        } else {
          return ErrorTextWidget(text: S.current.error);
        }
      },
    );
  }
}
