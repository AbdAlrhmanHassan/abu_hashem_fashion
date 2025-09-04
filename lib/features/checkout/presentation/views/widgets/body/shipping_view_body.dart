// import 'package:abu_hashem_fashion/core/widgets/custom_elevated_button.dart';
// import 'package:flutter/material.dart';

//  import '../checkout_status_row.dart';
// import '../payment_method_list_tile.dart';

// class ShippingViewBody extends StatefulWidget {
//   const ShippingViewBody({super.key});

//   @override
//   State<ShippingViewBody> createState() => _ShippingViewBodyState();
// }

// class _ShippingViewBodyState extends State<ShippingViewBody> {
//   bool isChecked = false;
//   bool isChecked2 = false;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           const CheckoutStatusRow(
//             statusNumber: 1,
//           ),
//           const SizedBox(height: 24),
//           PaymentMethodListTile(
//               isChecked: isChecked,
//               onTap: () {
//                 setState(() {
//                   isChecked2 == true ? isChecked2 = false : null;

//                   isChecked = !isChecked;
//                 });
//               },
//               title: 'الدفع عند الاستلام',
//               subtitle: 'التسليم من المكان',
//               trailingText: '40 جنيه'),
//           const SizedBox(height: 16),
//           PaymentMethodListTile(
//               isChecked: isChecked2,
//               onTap: () {
//                 setState(() {
//                   isChecked == true ? isChecked = false : null;
//                   isChecked2 = !isChecked2;
//                 });
//               },
//               title: 'اشتري الان وادفع لاحقا',
//               subtitle: 'يرجي تحديد طريقه الدفع',
//               trailingText: 'مجاني'),
//           const Spacer(),
//           CustomElevatedButton(
//               childV: const Text('التالي'),
//               onPressedF: () {
//                 // Navigator.pushNamed(context, AddressView.routeName);
//                 // Navigator.pushNamed(context, AddressView.routeName);
//               })
//         ],
//       ),
//     );
//   }
// }
