import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sneaker_store/scenes/home_page/widgets/sliver_bloc_consumer/sliver_grid_count/sliver_grid_count.dart';
import '../../../../generated/l10n.dart';
import '../../../product/product_bloc/product_bloc.dart';
import 'circular_loading.dart';
import 'empty_product_list.dart';
import 'error_text.dart';

class SliverBlocConsumer extends StatefulWidget {
  const SliverBlocConsumer({Key? key}) : super(key: key);

  @override
  _SliverBlocConsumerState createState() => _SliverBlocConsumerState();
}

class _SliverBlocConsumerState extends State<SliverBlocConsumer> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (BuildContext context, state) {
        if (state is HasDataState) {
          if (state.isUpdate) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data updated')));
          }
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return const CircularLoading();
        }
        if (state is HasDataState) {
          if(state.productList.isEmpty){
            return const EmptyProductList();
          }
          else{
            return SliverGridCount(state: state);
          }
        }
        if (state is ErrorState) {
          return ErrorText(text: '${S.current.error}' '${state.errorText}');
        } else {
          return ErrorText(text: S.current.error);
        }
      },
    );
  }
}
