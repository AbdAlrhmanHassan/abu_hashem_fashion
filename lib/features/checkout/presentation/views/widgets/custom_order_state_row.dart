import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/screen_size.dart';

class CustomOrderStateRow extends StatelessWidget {
  const CustomOrderStateRow({
    super.key,
    required this.imagePath,
    required this.title,
    this.subTitle,
    required this.isDone,
  });
  final String imagePath;
  final String title;
  final String? subTitle;
  final bool isDone;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          Container(
            width: getScreenHeight(context) * 0.08,
            height: getScreenHeight(context) * 0.08,
            decoration: ShapeDecoration(
              color: isDone
                  ? Colors.blue.withOpacity(.15)
                  : const Color(0xFFF5F5F5),
              shape: const OvalBorder(),
            ),
            child: Padding(
              padding: getScreenHeight(context) <= 650
                  ? const EdgeInsets.all(12.0)
                  : const EdgeInsets.all(16.0),
              // child: const Icon(Icons.check),
              child: isDone
                  ? Icon(
                      Icons.check,
                      color: Colors.grey[600],
                    )
                  : SvgPicture.asset(
                      imagePath,
                      color: Colors.grey[600],
                    ),
            ),
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subTitle == null
                  ? Container()
                  : Text(
                      subTitle!,
                      style: const TextStyle(
                        color: Color(0xFF949D9E),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    )
            ],
          )
        ],
      ),
    );
  }
}
