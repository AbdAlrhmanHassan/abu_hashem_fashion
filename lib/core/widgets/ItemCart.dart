import 'package:flutter/material.dart';

import '../style/font.dart';

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
