import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abu_hashem_fashion/features/cart/presintation/views/widgets/cart_item_cart_view.dart';
import 'package:abu_hashem_fashion/features/cart/presintation/views/widgets/cart_view_bottom.dart';
import 'package:abu_hashem_fashion/core/data/models/product_model.dart';

import '../../admin/cubit/cart_cubit.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: StreamBuilder<List<ProductModel>>(
        stream: cartCubit.getCartRealTimeData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          } else {
            List<ProductModel> productsList = snapshot.data!;

            // Create a map of productId to ProductModel for easy lookup
            final productMap = {
              for (var product in productsList) product.productId: product
            };

            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ListView.builder(
                      itemCount: cartCubit.getCartList.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartCubit.getCartList[index];
                        final product = productMap[cartItem.productId];

                        if (product == null) {
                          return Container(); // or a placeholder widget
                        }

                        return CartItem(
                          productModel: product,
                          quantity: cartItem.quantity,
                          cartModel: cartItem,
                        );
                      },
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CartViewBottom(
                    qty: cartCubit.getAllCartItemsQuantity(),
                    price: cartCubit.getAllCartItemsPrice() ?? 0,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
