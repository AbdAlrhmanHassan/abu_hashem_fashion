import 'package:abu_hashem_fashion/features/checkout/presentation/views/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_images.dart';
import '../../../../cart/data/order_model.dart';
import 'custom_order_state_row.dart';

class OrderStateCard extends StatelessWidget {
  const OrderStateCard({super.key, required this.orderModel});
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    List<String> orderStatuses = [
      'جاري التجهيز',
      'جار التوصيل',
      'تم التسليم',
      'ملغي',
    ];

    // Get the current status index
    int currentStatusIndex = orderStatuses.indexOf(orderModel.orderStatus);

    return Card(
      elevation: 0.4,
      shadowColor: Colors.transparent,
      shape: const Border(),
      child: Column(
        children: [
          const CustomDivider(),
          CustomOrderStateRow(
            imagePath: Assets.assetsImageTrackingOrderBoxClose,
            title: 'جاري التجهيز',
            subTitle: '22 مارس , 2024',
            isDone: currentStatusIndex >= 0 && currentStatusIndex != 3,
          ),
          const CustomDivider(),
          CustomOrderStateRow(
            imagePath: Assets.assetsImageTrackingOrderMap,
            title: 'جار التوصيل',
            subTitle: currentStatusIndex >= 1 && currentStatusIndex != 3
                ? '22 مارس , 2024'
                : 'قيد الانتظار',
            isDone: currentStatusIndex >= 1 && currentStatusIndex != 3,
          ),
          const CustomDivider(),
          CustomOrderStateRow(
            imagePath: Assets.assetsImageTrackingOrderDeliveryDone,
            title: 'تم تسليم',
            subTitle:
                currentStatusIndex == 2 ? 'تم التسليم بنجاح' : 'قيد الانتظار',
            isDone: currentStatusIndex == 2,
          ),
          if (currentStatusIndex == 3) ...[
            const CustomDivider(),
            const CustomOrderStateRow(
              imagePath: Assets.assetsImageTrackingOrderDeliveryDone,
              title: 'تم إلغاء الطلب',
              subTitle: 'الطلب ملغي',
              isDone: true,
            ),
          ],
        ],
      ),
    );
  }
}
