import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';

import '../../../../../core/style/font.dart';

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
