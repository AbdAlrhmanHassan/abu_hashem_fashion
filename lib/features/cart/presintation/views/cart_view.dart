import 'package:abu_hashem_fashion/core/widgets/custom_app_bar.dart';
import 'package:abu_hashem_fashion/features/cart/presintation/views/widgets/cart_view_bottom.dart';
import 'package:flutter/material.dart';

import 'widgets/cart_item_cart_view.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: customAppName(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ListView(
              children: [
                CartItem(screenheight: screenheight, screenwidth: screenwidth),
                CartItem(screenheight: screenheight, screenwidth: screenwidth),
                CartItem(screenheight: screenheight, screenwidth: screenwidth),
                CartItem(screenheight: screenheight, screenwidth: screenwidth),
                CartItem(screenheight: screenheight, screenwidth: screenwidth),
                CartItem(screenheight: screenheight, screenwidth: screenwidth),
              ],
            ),
          )),
          const Divider(
            thickness: 2,
            height: 6,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CartViewBottom(),
          )
        ]),
      ),
    );
  }
}
