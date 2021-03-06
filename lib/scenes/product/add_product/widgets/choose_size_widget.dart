import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/common/app_text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_utilities.dart';
import '../../../../generated/l10n.dart';

class ChooseSizeWidget extends StatefulWidget {
  final List<int>? selectedIndex;

  const ChooseSizeWidget({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  _ChooseSizeWidgetState createState() => _ChooseSizeWidgetState();
}

class _ChooseSizeWidgetState extends State<ChooseSizeWidget> {
  Color selectAllColor = AppColors.helperColor;

  List<Widget> _listAssembler() {
    List<Widget> widgets = [];
    List<int> list = AppUtilities.sizeList;
    for (int i = 0; i < AppUtilities.sizeList.length; i++) {
      widgets.add(InkWell(
          child: Container(
              height: MediaQuery.of(context).size.height / 16,
              width: MediaQuery.of(context).size.width / 8,
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: widget.selectedIndex!.contains(i)
                          ? Colors.amber
                          : Colors.white70,
                      width: 2)),
              child: Center(
                  child: Text('${list[i]}',
                      style: AppTextStyles.productModalTitleTextStyle))),
          onTap: () {
            if (widget.selectedIndex!.contains(i)) {
              setState(() {
                widget.selectedIndex!.remove(i);
              });
            } else {
              setState(() {
                widget.selectedIndex!.add(i);
              });
            }
          }));

      if (i != list.length - 1) {
        widgets.add(const SizedBox(width: 10));
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(S.current.chooseAvailableSizes,
                style: AppTextStyles.plainTextStyle),
            InkWell(
                child: Text(S.current.selectAll,
                    style: GoogleFonts.poppins(
                        color: selectAllColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w300)),
                onTap: () {
                  if (widget.selectedIndex!.length ==
                      AppUtilities.sizeList.length) {
                    setState(() {
                      selectAllColor = AppColors.helperColor;
                      widget.selectedIndex!.clear();
                    });
                  } else {
                    setState(() {
                      selectAllColor = AppColors.actionButtonColor;
                      widget.selectedIndex!.clear();
                      widget.selectedIndex!.addAll(List.generate(
                          AppUtilities.sizeList.length, (index) => index));
                    });
                  }
                })
          ])),
      SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
              margin: const EdgeInsets.only(bottom: 25),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _listAssembler())))
    ]);
  }
}