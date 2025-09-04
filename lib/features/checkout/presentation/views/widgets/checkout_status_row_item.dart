import 'package:abu_hashem_fashion/core/constants/screen_size.dart';
import 'package:flutter/material.dart';

class CheckoutStatusRowItem extends StatelessWidget {
  const CheckoutStatusRowItem({super.key, required this.title, this.number});
  final String title;
  final int? number;
  @override
  Widget build(BuildContext context) {
    return number == null
        ? Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.blue[400],
              ),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  color: Colors.blue[400],
                  fontSize: getScreenWidth(context) < 300 ? 10 : 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          )
        : Row(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: const ShapeDecoration(
                  color: Color(0xFFF2F3F3),
                  shape: CircleBorder(),
                ),
                child: Center(
                    child: Text(
                  number.toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700]),
                )),
              ),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  color: const Color(0xFFAAAAAA),
                  fontSize: getScreenWidth(context) < 300 ? 10 : 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );
  }
}
