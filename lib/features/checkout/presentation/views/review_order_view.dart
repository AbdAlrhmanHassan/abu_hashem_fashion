 import 'package:abu_hashem_fashion/core/data/models/user_address_model.dart';
import 'package:abu_hashem_fashion/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import 'widgets/body/review_order_view_body.dart';

class ReviewOrderView extends StatelessWidget {
  const ReviewOrderView({super.key});
  static const routeName = 'ReviewOrderView';
  @override
  Widget build(BuildContext context) {
    UserAddressModel userAddressModel =
        ModalRoute.of(context)?.settings.arguments as UserAddressModel;
    return Scaffold(
      // appBar: CustomAppBar(title: 'مراجعة الطلب', hideNotificationButton: true),
      appBar: AppBar(
        title: customAppName(),
      ),
      body: ReviewOrderViewBody(
        userAddressModel: userAddressModel,
      ),
    );
  }
}
