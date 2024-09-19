import 'package:abu_hashem_fashion/features/cart/presintation/admin/cubit/cart_cubit.dart';
import 'package:abu_hashem_fashion/features/cart/presintation/views/widgets/cart_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: customAppName(),
        ),
        body: const CartViewBody(),
      ),
    );
  }
}
