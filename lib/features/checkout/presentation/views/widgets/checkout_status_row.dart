import 'package:flutter/material.dart';

import 'checkout_status_row_item.dart';

class CheckoutStatusRow extends StatelessWidget {
  const CheckoutStatusRow({
    super.key,
    required this.statusNumber,
  });

  // static const List<String> _titles = ['الشحن', 'العنوان', 'الدفع', 'المراجعه'];
  static const List<String> _titles = [
    'العنوان',
    'المراجعه',
  ];
  final int statusNumber;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(_titles.length, (index) {
        if (index + 1 <= statusNumber) {
          return Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: CheckoutStatusRowItem(
              title: _titles[index],
            ),
          );
        } else {
          return CheckoutStatusRowItem(
            title: _titles[index],
            number: index + 1,
          );
        }
      }),
    );
  }
}
