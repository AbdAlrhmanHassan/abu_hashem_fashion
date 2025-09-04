import 'package:abu_hashem_fashion/core/utils/app_images.dart';
import 'package:abu_hashem_fashion/core/widgets/bottom_navigation_bar.dart';
import 'package:abu_hashem_fashion/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/screen_size.dart';
import 'order_tracking_view.dart';

class CheckoutDoneView extends StatelessWidget {
  const CheckoutDoneView({super.key, required this.orderId});
  final String orderId;
  static const routeName = 'CheckoutDoneView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: getScreenHeight(context) * 0.2),
            SvgPicture.asset(Assets.assetsImageSuccessAlert),
            const SizedBox(height: 32),
            const Text(
              'تم بنجاح !',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF0C0D0D),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'رقم الطلب : $orderId#',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF4E5556),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            CustomElevatedButton(
                textV: 'تتبع الطلب',
                onPressedF: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderTrackingView(orderId: orderId),
                    ),
                  );
                }),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, RootScreen.routName, (route) => false);
                Navigator.pushReplacementNamed(context, RootScreen.routName);
              },
              child: const Text(
                'الرئيسية',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
