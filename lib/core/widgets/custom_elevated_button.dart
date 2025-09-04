import 'package:abu_hashem_fashion/core/constants/screen_size.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key, this.childV, required this.onPressedF, this.textV});
  final Widget? childV;
  final void Function() onPressedF;
  final String? textV;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedF,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: Colors.blue[400],
        fixedSize: Size(getScreenWidth(context) * .5, 50),
        shadowColor: Colors.grey[300],
        elevation: 7,
      ),
      child: childV ??
          Text(
            '$textV',
            style: const TextStyle(
              // color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
    );
  }
}
