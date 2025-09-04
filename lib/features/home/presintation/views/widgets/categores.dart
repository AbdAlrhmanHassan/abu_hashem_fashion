import 'package:abu_hashem_fashion/features/search/presintation/views/search_view.dart';
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
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      crossAxisCount: 1,
      childAspectRatio: 1.2,
      padding: const EdgeInsets.all(10),
      children: List.generate(categoresItemsImagePath.length, (index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SearchView(
                      categories: categoresNames[index],
                    );
                  },
                ),
              );
            },
            child: Card(
              color: Colors.grey[50],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      categoresItemsImagePath[index],
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      categoresNames[index],
                      style: Styles.textStyle20
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
        );
      }),
    );
  }
}
