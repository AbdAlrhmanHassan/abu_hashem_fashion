// import 'package:flutter/material.dart';
// import '../../../../../../core/utils/app_images.dart';
// import '../payment_method.dart';

// class PaymentViewBody extends StatefulWidget {
//   const PaymentViewBody({super.key});

//   @override
//   State<PaymentViewBody> createState() => _PaymentViewBodyState();
// }

// class _PaymentViewBodyState extends State<PaymentViewBody> {
//   String? selectedPaymentMethod;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool checkBoxValue = false;

//   void _selectPaymentMethod(String imagePath) {
//     setState(() {
//       selectedPaymentMethod = imagePath;
//     });
//   }

//   // void _processPayment() {
//   //   if (_formKey.currentState?.validate() ?? false) {
//   //     if (selectedPaymentMethod == Assets.assetsImageApplePay) {
//   //       // Handle Apple Pay logic here
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(content: Text('Apple Pay selected')),
//   //       );
//   //     } else if (selectedPaymentMethod == Assets.assetsImagesPaypal) {
//   //       // Handle PayPal logic here
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(content: Text('PayPal selected')),
//   //       );
//   //     } else if (selectedPaymentMethod == Assets.assetsImagesMastercard ||
//   //         selectedPaymentMethod == Assets.assetsImagesVisa) {
//   //       // Handle credit card logic here
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(content: Text('Processing credit card payment')),
//   //       );
//   //     }
//   //     Navigator.pushNamed(context, ReviewOrderView.routeName);
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const CheckoutStatusRow(statusNumber: 3),
//           const SizedBox(height: 24),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'أختار طريقه الدفع المناسبه :',
//                       style: TextStyle(
//                         color: Color(0xFF0C0D0D),
//                         fontSize: 13,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     const Text(
//                       'من فضلك اختر طريقه الدفع المناسبه لك.',
//                       textAlign: TextAlign.right,
//                       style: TextStyle(
//                         color: Color(0xFF616A6B),
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     SizedBox(
//                       height: 54,
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: [
//                             PaymentMethod(
//                               imagePath: Assets.assetsImagesApplePay,
//                               isSelected: selectedPaymentMethod ==
//                                   Assets.assetsImagesApplePay,
//                               onTapF: () {
//                                 _selectPaymentMethod(
//                                     Assets.assetsImagesApplePay);
//                               },
//                             ),
//                             PaymentMethod(
//                               imagePath: Assets.assetsImagesPaypal,
//                               isSelected: selectedPaymentMethod ==
//                                   Assets.assetsImagesPaypal,
//                               onTapF: () => _selectPaymentMethod(
//                                   Assets.assetsImagesPaypal),
//                             ),
//                             PaymentMethod(
//                               imagePath: Assets.assetsImagesMastercard,
//                               isSelected: selectedPaymentMethod ==
//                                   Assets.assetsImagesMastercard,
//                               onTapF: () => _selectPaymentMethod(
//                                   Assets.assetsImagesMastercard),
//                             ),
//                             PaymentMethod(
//                               imagePath: Assets.assetsImagesVisa,
//                               isSelected: selectedPaymentMethod ==
//                                   Assets.assetsImagesVisa,
//                               onTapF: () =>
//                                   _selectPaymentMethod(Assets.assetsImagesVisa),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     if (selectedPaymentMethod != null &&
//                         (selectedPaymentMethod == Assets.assetsImagesVisa ||
//                             selectedPaymentMethod ==
//                                 Assets.assetsImagesMastercard)) ...[
//                       CustomTextField(
//                         hintText: 'اسم حامل البطاقه',
//                         validatorF: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'يرجى إدخال اسم حامل البطاقة';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 8),
//                       CustomTextField(
//                         hintText: 'رقم البطاقة',
//                         validatorF: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'يرجى إدخال رقم البطاقة';
//                           }
//                           if (value.length != 16 ||
//                               !RegExp(r'^\d+$').hasMatch(value)) {
//                             return 'يرجى إدخال رقم بطاقة صحيح مكون من 16 رقمًا';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: CustomTextField(
//                               hintText: 'تاريخ الصلاحيه',
//                               validatorF: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'يرجى إدخال تاريخ الصلاحية';
//                                 }
//                                 if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
//                                   return 'يرجى إدخال تاريخ صلاحية صحيح (MM/YY)';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: CustomTextField(
//                               hintText: 'CVV',
//                               validatorF: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'يرجى إدخال رمز CVV';
//                                 }
//                                 if (value.length != 3 ||
//                                     !RegExp(r'^\d{3}$').hasMatch(value)) {
//                                   return 'يرجى إدخال رمز CVV صحيح مكون من 3 أرقام';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       CustomCheckBoxWithTitle(
//                         checkBoxValue: checkBoxValue,
//                         onChangedF: (bool? value) {
//                           setState(() {
//                             checkBoxValue = !checkBoxValue;
//                           });
//                         },
//                       )
//                     ] else if (selectedPaymentMethod != null &&
//                         (selectedPaymentMethod == Assets.assetsImagesPaypal ||
//                             selectedPaymentMethod ==
//                                 Assets.assetsImagesApplePay)) ...[
//                       const CustomTextField(
//                         hintText: 'البريد الالكتروني',
//                         validatorF: validateEmail,
//                       ),
//                       const SizedBox(height: 8),
//                       const CustomTextField(
//                         hintText: 'كلمة المرور',
//                         validatorF: validatepassword,
//                       ),
//                       const SizedBox(height: 12),
//                       CustomCheckBoxWithTitle(
//                         checkBoxValue: checkBoxValue,
//                         onChangedF: (bool? value) {
//                           setState(() {
//                             checkBoxValue = !checkBoxValue;
//                           });
//                         },
//                       )
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           CustomButton(
//             text: 'أضف وسيلة دفع جديده',
//             onPressedF: _processPayment,
//           ),
//         ],
//       ),
//     );
//   }
// }
