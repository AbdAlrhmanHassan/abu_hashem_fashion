import 'package:abu_hashem_fashion/core/constants/screen_size.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
        color: const Color(0xffd6d7d7),
        indent: getScreenHeight(context) * .12,
        endIndent: getScreenWidth(context) * .12);
  }
}
