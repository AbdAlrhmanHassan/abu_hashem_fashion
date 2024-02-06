import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import '../../../../../core/constants/consts_photo.dart';

class SwiperHomePage extends StatelessWidget {
  const SwiperHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Swiper(
      autoplay: true,
      duration: 1000 * 5,
      autoplayDelay: 1000 * 10,
      itemCount: 3,
      pagination: SwiperPagination(
        margin: const EdgeInsets.all(3),
        alignment: Alignment.bottomCenter,
        builder: DotSwiperPaginationBuilder(
          size: 5,
          activeSize: 8,
          color: Colors.white,
          activeColor: Colors.grey[400]!,
        ),
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 2, left: 2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              ConstsAppImage.swiper1,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }
}
