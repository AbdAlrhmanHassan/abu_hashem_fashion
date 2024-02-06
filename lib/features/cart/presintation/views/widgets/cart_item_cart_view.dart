import 'package:abu_hashem_fashion/core/constants/screen_size.dart';
import 'package:abu_hashem_fashion/core/data/models/product_model.dart';
import 'package:abu_hashem_fashion/features/cart/presintation/admin/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';

import '../../../../../core/style/font.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.productModel});

  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Card(
        color: Colors.grey[200],
        child: SizedBox(
          height: getScreenHight(context) * .2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Text(
                            productModel.productTitle,
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InputQty.int(
                            initVal: 1,
                            minVal: 1,
                            maxVal: 12,
                            qtyFormProps: const QtyFormProps(
                              enableTyping: false,
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
                                  text: "JOD",
                                  style: Styles.textStyle14.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10)),
                              TextSpan(
                                  text: productModel.productPrice,
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
              Image.network(
                productModel.productImageUrl,
                width: (getScreenWidth(context) / 3) - 10,
                height: getScreenHight(context) * .2,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
