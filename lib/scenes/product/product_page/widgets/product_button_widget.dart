import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/common/app_textstyles.dart';

import '../../../../generated/l10n.dart';

class ProductButtonWidget extends StatefulWidget {
  final Future<void> Function() onTap;
  final bool isTapped;

  const ProductButtonWidget(
      {Key? key, required this.onTap, required this.isTapped})
      : super(key: key);

  @override
  _ProductButtonWidgetState createState() => _ProductButtonWidgetState();
}

class _ProductButtonWidgetState extends State<ProductButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
        child: InkResponse(
            child: Container(
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                    color: widget.isTapped
                        ? const Color(0xFF97fcca)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                    child: Text(
                        widget.isTapped
                            ? S.current.goToCart
                            : S.current.addToCart,
                        style: AppTextStyles.buttonTextStyle))),
            onTap: widget.onTap));
  }
}
