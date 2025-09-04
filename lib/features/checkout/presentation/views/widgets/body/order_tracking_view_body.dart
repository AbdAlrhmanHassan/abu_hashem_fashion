import 'package:abu_hashem_fashion/features/cart/data/order_model.dart';
import 'package:abu_hashem_fashion/features/cart/presintation/admin/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../order_card.dart';
import '../order_state_card.dart';

class OrderTrackingViewBody extends StatefulWidget {
  const OrderTrackingViewBody({super.key, required this.orderId});
  final String orderId;

  @override
  State<OrderTrackingViewBody> createState() => _OrderTrackingViewBodyState();
}

class _OrderTrackingViewBodyState extends State<OrderTrackingViewBody> {
  late OrderModel orderModel;
  @override
  void initState() {
    getOrderValue();
    super.initState();
  }

  Future<void> getOrderValue() async {
    orderModel = await BlocProvider.of<CartCubit>(context)
        .getOrderDetails(orderId: widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ExpansionTile(
            //   title: OrderCard(),
            //   children: [
            //     OrderStateCard(),
            //   ],
            // ),
            // ExpansionTile(
            //   title: OrderCard(),
            //   children: [
            //     OrderStateCard(),
            //   ],
            // ),
            // ExpansionTile(
            //   title: OrderCard(),
            //   children: [
            //     OrderStateCard(),
            //   ],
            // ),
            OrderCard(orderModel: orderModel),
            const SizedBox(height: 24),
            OrderStateCard(orderModel: orderModel),
          ],
        ),
      ),
    );
  }
}
