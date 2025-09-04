import 'package:abu_hashem_fashion/core/constants/screen_size.dart';
import 'package:abu_hashem_fashion/core/data/models/product_model.dart';
import 'package:flutter/material.dart';

class SearchitemCard extends StatelessWidget {
  const SearchitemCard({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          productModel.productTitle,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(width: 12),
                        if (productModel.getTotalQuantity() == 0)
                          const Text(
                            '(انتهى من المخزون)',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "JOD ",
                                style: DefaultTextStyle.of(context)
                                    .style
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                            TextSpan(
                              text: productModel.productPrice,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                  color: Colors.white,
                  width: getScreenWidth(context) * .25,
                  height: getScreenHeight(context) * .15,
                  child: Image.network(
                    productModel.productImageUrl,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
