import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/app_images.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: .4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'وسيلة الدفع',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {},
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(Assets.assetsImageEditIcon),
                      ),
                      const Text(
                        'تعديل',
                        style: TextStyle(
                            color: Color(0xFF949D9E),
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 6,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Spacer(),
                Text(
                  '**** **** **** 6522',
                  style: TextStyle(
                      color: Color(0xFF4E5556),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 0.09),
                ),
                SizedBox(width: 24),
                // SvgPicture.asset(
                //   Assets.assetsImageVisaIcon,
                //   width: 53,
                //   height: 34,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
