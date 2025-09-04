import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.text,
    required this.onPressedF,
    required this.leadingIcon,
  });
  final String text;
  final void Function() onPressedF;
  final Widget leadingIcon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue[400]!),
                borderRadius: BorderRadius.circular(16.0))),
        backgroundColor: WidgetStateProperty.all(Colors.white),
        fixedSize: WidgetStateProperty.all(const Size(double.maxFinite, 54)),
      ),
      onPressed: onPressedF,
      child: ListTile(
        leading: leadingIcon,
        title: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
    );
  }
}
