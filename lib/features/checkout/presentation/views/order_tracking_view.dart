import 'package:abu_hashem_fashion/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import 'widgets/body/order_tracking_view_body.dart';
 
class OrderTrackingView extends StatelessWidget {
  const OrderTrackingView({super.key,  required this.orderId});
  final String orderId;
  
  static const String routeName = 'OrderTrackingView';
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      // appBar: CustomAppBar(
      //   title: 'تتبع الطلب',
      //   hideNotificationButton: true,
      // ),
      appBar: AppBar(title: customAppName(),),
      body:   OrderTrackingViewBody(orderId :orderId),
    );
  }
}
