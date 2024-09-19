import 'dart:developer';

import 'package:abu_hashem_fashion/core/constants/screen_size.dart';
import 'package:abu_hashem_fashion/core/data/models/product_model.dart';
import 'package:abu_hashem_fashion/features/cart/data/cart_model.dart';
import 'package:abu_hashem_fashion/features/cart/presintation/admin/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';

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
  @override
  void initState() {
    log("Quantity ${widget.quantity}");

    if (widget.quantity > int.parse(widget.productModel.productQuantity)) {
      BlocProvider.of<CartCubit>(context).quantityChange(
          cartId: widget.cartModel.cartId,
          qty: int.parse(widget.productModel.productQuantity),
          productId: widget.productModel.productId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("Quantity ${widget.quantity}");
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Card(
        color: Colors.grey[100],
        child: SizedBox(
          height: getScreenHight(context) * .2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.productModel.productTitle,
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          int.parse(widget.productModel.productQuantity) <= 8
                              ? Text(
                                  'الكمية المتبقية : ${widget.productModel.productQuantity} ',
                                  style: Styles.textStyle14
                                      .copyWith(color: Colors.red),
                                )
                              : Container()
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InputQty.int(
                            onQtyChanged: (value) {
                              BlocProvider.of<CartCubit>(context)
                                  .quantityChange(
                                      cartId: widget.cartModel.cartId,
                                      qty: value,
                                      productId: widget.productModel.productId);
                            },
                            initVal: int.parse(
                                        widget.productModel.productQuantity) >=
                                    widget.quantity
                                ? widget.quantity
                                : int.parse(
                                    widget.productModel.productQuantity),
                            minVal: 1,
                            maxVal: num.parse(
                                        widget.productModel.productQuantity) >=
                                    12
                                ? 12
                                : num.parse(
                                    widget.productModel.productQuantity),
                            qtyFormProps: const QtyFormProps(
                              enableTyping: true,
                            ),
                            decoration: QtyDecorationProps(
                                border: InputBorder.none,
                                isBordered: false,
                                borderShape: BorderShapeBtn.circle,
                                btnColor: Colors.blue[300]!),
                          ),
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
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Stack(children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: Image.network(
                    widget.productModel.productImageUrl,
                    width: (getScreenWidth(context) / 3) - 10,
                    height: getScreenHight(context) * .2,
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      BlocProvider.of<CartCubit>(context).deleteCartItem(
                        cartId: widget.cartModel.cartId,
                        productId: widget.productModel.productId,
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
