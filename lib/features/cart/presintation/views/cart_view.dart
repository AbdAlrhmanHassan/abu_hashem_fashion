import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/models/product_model.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../home/presintation/admin/cubit/view_all_products_cubit.dart';
import '../../data/cart_model.dart';
import '../admin/cubit/cart_cubit.dart';
import 'widgets/cart_item_cart_view.dart';

import 'widgets/cart_view_bottom.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ViewAllProductsCubit>(context).fetchProducts();
    BlocProvider.of<CartCubit>(context).fetchCart();

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CartSuccess) {
          List<CartModel> cartItemsL = state.cartItems;
          log(cartItemsL.length.toString());
          return Scaffold(
            appBar: AppBar(
              title: customAppName(),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ListView.builder(
                        itemCount: cartItemsL.length,
                        itemBuilder: (BuildContext context, int index) {
                          return FutureBuilder<ProductModel?>(
                            future:
                                BlocProvider.of<ViewAllProductsCubit>(context)
                                    .findByProdId(
                                        productId: cartItemsL[index].cartId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                return CartItem(
                                  productModel: snapshot.data!,
                                );
                              } else {
                                return const SizedBox(); // Handle no data case
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    height: 6,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CartViewBottom(),
                  ),
                ],
              ),
            ),
          );
        } else if (state is CartFailure) {
          return Text(state.errorMsg);
        } else {
          return const Text("ERROR");
        }
      },
    );
  }
}
