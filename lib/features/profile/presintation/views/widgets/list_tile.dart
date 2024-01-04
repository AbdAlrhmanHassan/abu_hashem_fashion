import 'package:flutter/material.dart';

import '../../../../../core/style/font.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.imagePath,
      required this.text,
      required this.function});
  final String imagePath, text;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        onTap: () {
          function();
        },
        trailing: Image.asset(
          imagePath,
          height: 30,
        ),
        title: Text(
          text,
          style: Styles.textStyle20
              .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
          textDirection: TextDirection.rtl,
        ),
        leading: const Icon(Icons.keyboard_arrow_left),
      ),
    );
  }
}
