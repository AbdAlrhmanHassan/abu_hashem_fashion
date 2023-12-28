import 'package:abu_hashem_fashion/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/style/font.dart';
import 'package:input_quantity/input_quantity.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: customAppName(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ListView(
              children: [
                CartItem(screenheight: screenheight, screenwidth: screenwidth),
                CartItem(screenheight: screenheight, screenwidth: screenwidth),
                CartItem(screenheight: screenheight, screenwidth: screenwidth),
                CartItem(screenheight: screenheight, screenwidth: screenwidth),
                CartItem(screenheight: screenheight, screenwidth: screenwidth),
                CartItem(screenheight: screenheight, screenwidth: screenwidth),
              ],
            ),
          )),
          const Divider(
            thickness: 2,
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                Column(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "عدد القطع : ",
                          style: Styles.textStyle16.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: " 6",
                          style: Styles.textStyle14.copyWith(
                              color: Colors.blue[400],
                              fontWeight: FontWeight.bold)),
                    ])),
                    const SizedBox(
                      height: 3,
                    ),
                    RichText(
                        textDirection: TextDirection.rtl,
                        text: TextSpan(children: [
                          TextSpan(
                              text: "المجموع الكلي : ",
                              style: Styles.textStyle16.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: " JOD",
                              style: Styles.textStyle14.copyWith(
                                  color: Colors.blue[400],
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: " 87",
                              style: Styles.textStyle18.copyWith(
                                  color: Colors.blue[400],
                                  fontWeight: FontWeight.bold)),
                        ])),
                  ],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.blue[100],
                      side: const BorderSide(color: Colors.white, width: 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "تأكيد الطلب",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    )),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.screenheight,
    required this.screenwidth,
  });

  final double screenheight;
  final double screenwidth;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Card(
        color: Colors.grey[200],
        child: SizedBox(
          height: screenheight * .2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Text(
                            "تيشيرت من القطن بأكمام قصيرة",
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InputQty.int(
                            initVal: 1,
                            minVal: 1,
                            maxVal: 12,
                            qtyFormProps: const QtyFormProps(
                              enableTyping: false,
                            ),
                            decoration: QtyDecorationProps(
                                border: InputBorder.none,
                                isBordered: false,
                                borderShape: BorderShapeBtn.circle,
                                btnColor: Colors.blue[300]!),
                          ),
                          RichText(
                              text: TextSpan(
                            children: [
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
                                  ))
                            ],
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // Shimmer.fromColors(
              //   baseColor: Colors.grey[400]!,
              //   highlightColor: Colors.grey[300]!,
              //   period: Duration(seconds: 3),
              //   direction: ShimmerDirection.rtl,
              //   child: Image.network(
              //     "https://static.massimodutti.net/3/photos//2024/V/0/1/p/6823/540/800/6823540800_1_1_16.jpg?t=1693385316266&impolicy=massimodutti-itxmediumhigh&imwidth=800&imformat=chrome",
              //     width: (screenwidth / 3) - 10,
              //     height: screenheight * .2,
              //     fit: BoxFit.fill,
              //   ),
              // )
              Image.network(
                "https://static.massimodutti.net/3/photos//2024/V/0/1/p/6823/540/800/6823540800_1_1_16.jpg?t=1693385316266&impolicy=massimodutti-itxmediumhigh&imwidth=800&imformat=chrome",
                width: (screenwidth / 3) - 10,
                height: screenheight * .2,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
