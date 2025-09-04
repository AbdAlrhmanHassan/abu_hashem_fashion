import 'package:flutter/material.dart';

class PaymentMethodListTile extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onTap;
  final String title;
  final String subtitle;
  final String trailingText;

  const PaymentMethodListTile({
    super.key,
    required this.isChecked,
    required this.onTap,
    required this.title,
    required this.subtitle,
    required this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: const Color(0xfff7f7f7),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      splashColor: Colors.transparent,
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: isChecked
            ? const BorderSide(color: Color(0xff1B5E37))
            : BorderSide.none,
      ),
      leading: isChecked
          ? Container(
              width: 18,
              height: 18,
              decoration: const ShapeDecoration(
                color: Color(0xFF1B5E37),
                shape: OvalBorder(
                  side: BorderSide(width: 4, color: Colors.white),
                ),
              ),
            )
          : Container(
              width: 18,
              height: 18,
              decoration: const ShapeDecoration(
                shape: OvalBorder(
                  side: BorderSide(width: 1, color: Color(0xFF949D9E)),
                ),
              ),
            ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      subtitle: Text(
        subtitle,
        textAlign: TextAlign.right,
        style: TextStyle(
          color: Colors.black.withOpacity(0.5),
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Text(
        trailingText,
        style: const TextStyle(
          color: Color(0xFF3A8B33),
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
