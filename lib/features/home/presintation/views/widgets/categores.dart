import 'package:flutter/material.dart';

import '../../../../../core/constants/consts_photo.dart';
import '../../../../../core/style/font.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.2,
      padding: const EdgeInsets.all(10),
      children: List.generate(categoresItemsImagePath.length, (index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Card(
            color: Colors.grey[50],
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    categoresItemsImagePath[index],
                    width: 70,
                    height: 70,
                  ),
                  Text(
                    categoresNames[index],
                    style: Styles.textStyle20
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ]),
          ),
        );
      }),
    );
  }
}
