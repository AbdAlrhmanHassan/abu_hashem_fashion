import 'package:abu_hashem_fashion/core/consts/consts_photo.dart';
import 'package:abu_hashem_fashion/core/style/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import '../../../../core/widgets/custom_app_bar.dart';

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
                child: Swiper(
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
                ),
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
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                padding: const EdgeInsets.all(10),
                children:
                    List.generate(categoresItemsImagePath.length, (index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Card(
                      color: Colors.grey[200],
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
              ),
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

class ItemCart extends StatelessWidget {
  const ItemCart({
    super.key,
    required this.screenwidth,
  });

  final double screenwidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (screenwidth / 2) - 5,
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Image.network(
              "https://static.massimodutti.net/3/photos//2024/V/0/1/p/6823/540/800/6823540800_1_1_16.jpg?t=1693385316266&impolicy=massimodutti-itxmediumhigh&imwidth=800&imformat=chrome",
              width: (screenwidth / 2) - 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              child: Text(
                "تيشيرت من القطن بأكمام قصيرة",
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 0, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {},
                    child: const Icon(
                      Icons.add_shopping_cart_outlined,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "JOD",
                          style: Styles.textStyle14.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                      TextSpan(
                          text: "35.50",
                          style: Styles.textStyle16.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                    ]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
