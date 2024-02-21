import 'package:flutter/material.dart';

import '../../../../../core/style/font.dart';

class CartViewBottom extends StatelessWidget {
  const CartViewBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.rtl,
      children: [
        Column(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "عدد القطع : ",
                  style: Styles.textStyle16.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: " 6",
                  style: Styles.textStyle14.copyWith(
                      color: Colors.blue[400], fontWeight: FontWeight.bold)),
            ])),
            const SizedBox(
              height: 3,
            ),
            RichText(
                textDirection: TextDirection.rtl,
                text: TextSpan(children: [
                  TextSpan(
                      text: "المجموع الكلي : ",
                      style: Styles.textStyle16.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: " JOD",
                      style: Styles.textStyle14.copyWith(
                          color: Colors.blue[400],
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: " 87",
                      style: Styles.textStyle18.copyWith(
                          color: Colors.blue[400],
                          fontWeight: FontWeight.bold)),
                ])),
          ],
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[100],
              side: const BorderSide(color: Colors.white, width: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "تأكيد الطلب",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            )),
      ],
    );
  }
}
