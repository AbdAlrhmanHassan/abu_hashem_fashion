import 'package:abu_hashem_fashion/core/data/models/user_address_model.dart';
import 'package:flutter/material.dart';

class DeliveryAddressCard extends StatelessWidget {
  const DeliveryAddressCard({super.key, required this.userAddressModel});
  final UserAddressModel userAddressModel;
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
                  'عنوان التوصيل',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.edit),
                        // child: SvgPicture.asset(Assets.assetsImagesEditIcon),
                      ),
                      Text(
                        'تعديل',
                        style: TextStyle(
                            color: Color(0xFF949D9E),
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 6,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 8),
                //TODO:try to remove Expanded
                Expanded(
                  child: Text(
                    '${userAddressModel.governorate}, ${userAddressModel.city},\n${userAddressModel.address}${userAddressModel.apartmentNumber == null ? '.' : ',\n رقم المبنى : ${userAddressModel.apartmentNumber!} .'}',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Color(0xFF4E5556),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
