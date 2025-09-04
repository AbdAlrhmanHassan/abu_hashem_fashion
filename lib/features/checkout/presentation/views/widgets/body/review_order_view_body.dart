import 'package:abu_hashem_fashion/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../core/data/models/user_address_model.dart';
import '../../../../../cart/presintation/admin/cubit/cart_cubit.dart';
import '../../checkout_done_view.dart';
import '../checkout_status_row.dart';
import '../delivery_address_card.dart';
import '../order_summary_card.dart';
import '../section_title.dart';

class ReviewOrderViewBody extends StatefulWidget {
  const ReviewOrderViewBody({super.key, required this.userAddressModel});
  final UserAddressModel userAddressModel;

  @override
  State<ReviewOrderViewBody> createState() => _ReviewOrderViewBodyState();
}

class _ReviewOrderViewBodyState extends State<ReviewOrderViewBody> {
  late double deliveryPrice;
  bool isLoading = false;
  @override
  void initState() {
    getDeliveryPrice();
    super.initState();
  }

  Future<void> getDeliveryPrice() async {
    isLoading = true;
    setState(() {});
    deliveryPrice = await BlocProvider.of<CartCubit>(context).getDeliveryPrice(
            governorate: widget.userAddressModel.governorate) ??
        5;
    isLoading = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.blue[400],
            ))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CheckoutStatusRow(statusNumber: 2),
                const SizedBox(height: 24),
                const SectionTitle(title: 'ملخص الطلب :'),
                const SizedBox(height: 12),
                OrderSummaryCard(
                  userAddressModel: widget.userAddressModel,
                  deliveryPrice: deliveryPrice,
                ),
                const SizedBox(height: 12),
                const SectionTitle(title: 'يرجي تأكيد طلبك'),
                // const SizedBox(height: 12),
                // const PaymentMethodCard(),
                const SizedBox(height: 12),
                DeliveryAddressCard(
                  userAddressModel: widget.userAddressModel,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                        textV: 'تأكيد الطلب',
                        onPressedF: () {
                          String orderId = const Uuid().v4();

                          BlocProvider.of<CartCubit>(context).addOrder(
                            userAddressModel: widget.userAddressModel,
                            deliveryPrice: deliveryPrice,
                            orderId: orderId,
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>   CheckoutDoneView(
                                orderId: orderId,
                              ),
                            ),
                          );
                        }),
                  ],
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            ),
    );
  }
}
