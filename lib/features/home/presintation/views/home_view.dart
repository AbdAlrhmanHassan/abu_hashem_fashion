import 'package:abu_hashem_fashion/core/style/font.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/ItemCart.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import 'widgets/categores.dart';
import 'widgets/swiper.dart';

class HomeView extends StatelessWidget {
  static String routName = "/HomeView";
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: customAppName()),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenheight * .22,
                child: const SwiperHomePage(),
              ),
              const SizedBox(height: 16),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    "الفئات",
                    style: Styles.textStyle20
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Categories(),
              const SizedBox(height: 6),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    "من أجلك",
                    style: Styles.textStyle20
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(height: 10),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 5 / 9,
                children: [
                  ItemCart(screenwidth: screenwidth),
                  ItemCart(screenwidth: screenwidth),
                  ItemCart(screenwidth: screenwidth),
                  ItemCart(screenwidth: screenwidth),
                  ItemCart(screenwidth: screenwidth),
                  ItemCart(screenwidth: screenwidth),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
