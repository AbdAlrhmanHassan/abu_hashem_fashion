import 'package:abu_hashem_fashion/features/cart/data/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/screen_size.dart';
import '../../../../../core/utils/app_images.dart';
import 'order_details.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.orderModel});
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      elevation: 0.4,
      shape: const Border(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          children: [
            Container(
              width: getScreenHeight(context) * 0.08,
              height: getScreenHeight(context) * 0.08,
              decoration: ShapeDecoration(
                color: Colors.blue.withOpacity(.15),
                shape: const OvalBorder(),
              ),
              child: Padding(
                padding: getScreenHeight(context) <= 650
                    ? const EdgeInsets.all(12.0)
                    : const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  Assets.assetsImageTrackingOrderBoxClose,
                  fit: BoxFit.contain,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(width: 16),
            OrderDetails(orderModel: orderModel),
          ],
        ),
      ),
    );
  }
}
