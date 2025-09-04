import 'dart:developer';

import 'package:abu_hashem_fashion/core/constants/screen_size.dart';
import 'package:abu_hashem_fashion/core/data/models/product_model.dart';
import 'package:abu_hashem_fashion/features/cart/data/cart_model.dart';
import 'package:abu_hashem_fashion/features/cart/presintation/admin/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/style/font.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    super.key,
    required this.cartModel,
    required this.productModel,
    required this.quantity,
  });
  final ProductModel productModel;
  final int quantity;
  final CartModel cartModel;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int quantityInDB;

  @override
  void initState() {
    getProductQuantity();
    // if (widget.quantity > int.parse(widget.productModel.productQuantity)) {
    //   BlocProvider.of<CartCubit>(context).quantityChange(
    //       cartId: widget.cartModel.cartId,
    //       qty: int.parse(widget.productModel.productQuantity),
    //       productId: widget.productModel.productId);
    // }
    super.initState();
  }

  void getProductQuantity() {
    quantityInDB = widget.productModel.sizeAndColorQtyMap[widget.cartModel
        .sizeAndColorMap['size']]![widget.cartModel.sizeAndColorMap['color']]!;
    // quantityInDB= widget.cartModel.sizeAndColorMap[widget.productModel. productId]?[widget.cartModel.sizeAndColorMap];
  }

  @override
  Widget build(BuildContext context) {
    log('quantityInDB: $quantityInDB');
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey[350]!),
          borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[50],
      child: SizedBox(
        height: getScreenHeight(context) * .22,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productModel.productTitle,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        quantityInDB <= 8
                            ? Text(
                                'الكمية المتبقية : $quantityInDB ',
                                style: Styles.textStyle14
                                    .copyWith(color: Colors.red),
                              )
                            : Container(),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'المقاس : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.cartModel.sizeAndColorMap['size'],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'اللون : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                CircleAvatar(
                                    radius: 15,
                                    backgroundColor: widget.cartModel
                                        .sizeAndColorMap['color'] as Color?),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                          children: [
                            TextSpan(
                                text: "JOD ",
                                style: Styles.textStyle14.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10)),
                            TextSpan(
                                text:
                                    '${double.parse(widget.productModel.productPrice) * widget.quantity}',
                                style: Styles.textStyle16.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ))
                          ],
                        )),
                        Theme(
                          data: Theme.of(context).copyWith(
                            inputDecorationTheme: const InputDecorationTheme(
                              border: InputBorder.none, // Removes border
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                          child: InputQty.int(
                            onQtyChanged: (value) {
                              BlocProvider.of<CartCubit>(context)
                                  .quantityChange(
                                cartId: widget.cartModel.cartId,
                                qty: value,
                                productId: widget.productModel.productId,
                              );
                            },
                            initVal: quantityInDB >= widget.quantity
                                ? widget.quantity
                                : quantityInDB,
                            minVal: 1,
                            maxVal: quantityInDB >= 12 ? 12 : quantityInDB,
                            qtyFormProps: const QtyFormProps(
                              enableTyping: false,
                              showCursor: false,
                            ),
                            decoration: QtyDecorationProps(
                              borderShape: BorderShapeBtn.circle,
                              btnColor: Colors.blue[300]!,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Stack(children: [
              Container(
                color: Colors.white,
                width: (getScreenWidth(context) / 3) - 10,
                height: getScreenHeight(context) * .22,
                child: Image.network(
                  widget.productModel.productImageUrl,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child; // Once the image is loaded, display it
                    } else {
                      // Show a shimmer effect while the image is loading
                      return Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.grey[400]!,
                        child: Container(
                          width: (getScreenWidth(context) / 2) - 10,
                          height: getScreenHeight(context) / 3.2,
                          color:
                              Colors.red[300], // Placeholder color for shimmer
                        ),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.error,
                      color: Colors.red,
                    );
                  },
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: IconButton(
                    onPressed: () async {
                      BlocProvider.of<CartCubit>(context)
                          .deleteCartItemByProductId(
                        productId: widget.productModel.productId,
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
