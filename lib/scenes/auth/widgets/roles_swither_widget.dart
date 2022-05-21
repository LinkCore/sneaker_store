import 'package:flutter/material.dart';

class RolesSwitcherWidget extends StatefulWidget {
  final double height;
  final TextStyle floatingWidgetTextStyle;
  final TextStyle backgroundTextStyle;
  final Color floatingWidgetColor;
  final Color backgroundColor;
  final String leftText;
  final String rightText;
  final double width;
  final VoidCallback onTap;

  RolesSwitcherWidget(
      {Key? key,
        VoidCallback? onTap,
        double? height,
        Color? floatingWidgetColor,
        Color? backgroundColor,
        TextStyle? floatingWidgetTextStyle,
        TextStyle? backgroundTextStyle,
        String? leftText,
        String? rightText,
        double? width})
      : height = height ?? 60,
        width = width ?? 300,
        onTap = onTap ?? (() {}),
        floatingWidgetColor = floatingWidgetColor ?? Colors.white,
        backgroundColor = backgroundColor ?? Colors.white,
        floatingWidgetTextStyle = floatingWidgetTextStyle ??
            const TextStyle(fontSize: 20, color: Colors.black),
        backgroundTextStyle = backgroundTextStyle ??
            const TextStyle(fontSize: 20, color: Colors.black),
        leftText = leftText ?? "Variant 1",
        rightText = rightText ?? "Variant 2",
        super(key: key);

  @override
  _RolesSwitcherWidgetState createState() => _RolesSwitcherWidgetState();
}

class _RolesSwitcherWidgetState extends State<RolesSwitcherWidget> {
  bool isEnabled = false;
  Widget child = const Text("");

  @override
  void initState() {
    child = Text(widget.leftText,
        style: widget.floatingWidgetTextStyle, key: Key(widget.leftText));
    super.initState();
  }

  Future<void> onInteractive() async {
    setState(() {
      isEnabled = !isEnabled;
      child = const Text("    ", key: Key("plain"));
    });
    await Future.delayed(const Duration(milliseconds: 400)).then((value) {
      if (isEnabled) {
        setState(() {
          child = Text(widget.rightText,
              style: widget.floatingWidgetTextStyle,
              key: Key(widget.rightText));
        });
      } else {
        setState(() {
          child = Text(widget.leftText,
              style: widget.floatingWidgetTextStyle, key: Key(widget.leftText));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              onInteractive();
              widget.onTap();
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: widget.backgroundColor),
              height: widget.height,
              width: widget.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Center(
                          child: Text(widget.leftText,
                              style: widget.backgroundTextStyle))),
                  Expanded(
                      child: Center(
                          child: Text(widget.rightText,
                              style: widget.backgroundTextStyle)))
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            curve: Curves.easeInQuart,
            left: isEnabled ? (widget.width / 2) : 0,
            duration: const Duration(milliseconds: 500),
            child: GestureDetector(
              onHorizontalDragUpdate: (updateParam) {
                onInteractive();
                widget.onTap();
              },
              onHorizontalDragStart: (startParam) {
                onInteractive();
                widget.onTap();
              },
              onHorizontalDragDown: (downParam) {
                onInteractive();
                widget.onTap();
              },
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1,
                          offset: const Offset(-0.5, 0),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.2)),
                      BoxShadow(
                          spreadRadius: 1,
                          offset: const Offset(0.5, 0),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.2))
                    ],
                    color: widget.floatingWidgetColor,
                    borderRadius: BorderRadius.circular(15)),
                height: widget.height,
                width: (widget.width / 2),
                child: Center(
                  child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 550),
                      child: child),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
