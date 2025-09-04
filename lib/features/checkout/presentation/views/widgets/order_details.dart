
import 'package:abu_hashem_fashion/features/cart/data/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.orderModel});
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(
            ClipboardData(text: orderModel.orderId)); // Copy the text
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('تم نسخ رقم الطلب!')), // Optional feedback
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'رقم الطلب :  ',
                style: TextStyle(
                  color: Color(0xFF949D9E),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                orderModel.orderId,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text(
                'تم الطلب : ',
                style: TextStyle(
                  color: Color(0xFF949D9E),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                DateFormat('hh:mm a , EEEE , dd/MM/yyyy', 'ar')
                    .format(orderModel.orderDate.toDate()),
                style: const TextStyle(
                  color: Color(0xFF0C0D0D),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text(
                'عدد المنتجات : ',
                style: TextStyle(
                  color: Color(0xFF949D9E),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                orderModel.quantity.toString(),
                style: const TextStyle(
                  color: Color(0xFF0C0D0D),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(width: 4),
          Row(
            children: [
              const Text(
                'السعر النهائي : ',
                style: TextStyle(
                  color: Color(0xFF949D9E),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                orderModel.totalPrice.toString(),
                style: const TextStyle(
                  color: Color(0xFF0C0D0D),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
