 import 'package:abu_hashem_fashion/core/data/models/user_address_model.dart';
import 'package:abu_hashem_fashion/features/cart/presintation/admin/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'summary_row.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard(
      {super.key, required this.userAddressModel, required this.deliveryPrice});
  final UserAddressModel userAddressModel;
  final double deliveryPrice;
  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);

    return Card(
      color: Colors.white,
      elevation: .4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SummaryRow(
              title: 'المجموع الفرعي :',
              value: cartCubit.getAllCartItemsPrice().toString(),
              titleStyle: const TextStyle(
                  color: Color(0xFF4E5556),
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
              valueStyle: const TextStyle(
                  color: Color(0xFF0C0D0D),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            SummaryRow(
              title: 'التوصيل إلى ${userAddressModel.governorate} :',
              value: deliveryPrice.toString(),
              titleStyle: const TextStyle(
                  color: Color(0xFF4E5556),
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
              valueStyle: const TextStyle(
                  color: Color(0xFF4E5556),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 0.13),
            ),
            const SizedBox(height: 12),
            const Divider(color: Color(0xFFCACECE), indent: 16, endIndent: 16),
            const SizedBox(height: 12),
            SummaryRow(
              title: 'الكلي',
              value:
                  '${cartCubit.getAllCartItemsPrice() + deliveryPrice} دينار',
              titleStyle: const TextStyle(
                  color: Color(0xFF0C0D0D),
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
              valueStyle: const TextStyle(
                  color: Color(0xFF0C0D0D),
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
