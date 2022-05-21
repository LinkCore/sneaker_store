import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cart_bloc/cart_bloc.dart';

class CartProductWidget extends StatefulWidget {
  final CartHasDataState state;
  const CartProductWidget({Key? key, required this.state}) : super(key: key);

  @override
  _CartProductWidgetState createState() => _CartProductWidgetState();
}

class _CartProductWidgetState extends State<CartProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < widget.state.productList.length; i++)
                  Dismissible(
                    key: Key(i.toString()),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 10,
                            width: MediaQuery.of(context).size.height / 10,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(widget.state
                                    .productList[i]
                                    .imagesUrls!
                                    .first),
                              ),
                              borderRadius:
                              BorderRadius.circular(15),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection:
                                  Axis.horizontal,
                                  child: Text(
                                    widget.state.productList[i]
                                        .productName!,
                                    style:
                                    GoogleFonts.poppins(
                                        fontSize: 16),
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  widget.state.productList[i]
                                      .description!,
                                  style:
                                  GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight:
                                      FontWeight
                                          .w300,
                                      color: Colors
                                          .white54),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  widget.state.productList[i]
                                      .sizedList!.first
                                      .toString(),
                                  style:
                                  GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight:
                                      FontWeight
                                          .w500,
                                      color: Colors
                                          .white54),
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  "\$ ${widget.state.productList[i].price.toString()}",
                                  style:
                                  GoogleFonts.poppins(
                                      fontSize: 22,
                                      fontWeight:
                                      FontWeight
                                          .w500),
                                ),
                              )),
                        ],
                      ),
                    ),
                    onDismissed:
                        (DismissDirection direction) {
                      if (direction ==
                          DismissDirection.endToStart) {
                        context.read<CartBloc>().add(
                            DeleteProductEvent(
                                product:
                                widget.state.productList[i]));
                      } else {
                        context.read<CartBloc>().add(
                            DeleteProductEvent(
                                product:
                                widget.state.productList[i]));
                      }
                    },
                  ),
              ],
            )));
  }
}
