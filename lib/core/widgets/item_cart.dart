import 'package:abu_hashem_fashion/features/cart/presintation/admin/cubit/cart_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/screen_size.dart';
import '../data/models/product_model.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.productModell, required this.qty});
  final ProductModel productModell;
  final int qty;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (getScreenWidth(context) / 2) - 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Card(
          elevation: 3,
          color: Colors.grey[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: productModell.productImageUrl,
                width: (getScreenWidth(context) / 2) - 10,
                height: (getScreenHight(context) / 3.2),
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      productModell.productTitle,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 0, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: Colors.grey[200],
                        side: const BorderSide(color: Colors.black, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {
                        final User? user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          BlocProvider.of<CartCubit>(context).addToCartFirebase(
                              productId: productModell.productId, qty: qty);
                        }
                      },
                      child: const Icon(
                        Icons.add_shopping_cart_outlined,
                        color: Colors.black,
                        size: 18,
                      ),
                    ),
                    RichText(
                      // strutStyle: StrutStyle(),
                      text: TextSpan(children: [
                        TextSpan(
                            text: "JOD ",
                            style: DefaultTextStyle.of(context).style.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 10)),
                        TextSpan(
                            text: productModell.productPrice,
                            style: DefaultTextStyle.of(context).style.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                      ]),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
