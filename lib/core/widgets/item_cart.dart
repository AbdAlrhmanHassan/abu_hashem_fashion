import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../../../core/constants/screen_size.dart';
import '../../features/home/presintation/admin/cubit/view_all_products_cubit.dart';
import '../data/models/product_model.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({super.key, required this.productModell});
  final ProductModel productModell;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool isLoading = false;
  // bool areAllSizesOutOfStock(ProductModel productModell) {
  //   // Iterate through each size and its color quantity map
  //   for (Map<Color, int?>? colorQtyMap
  //       in productModell.sizeAndColorQtyMap.values) {
  //     // If colorQtyMap is not null, check if any color has a quantity greater than 0
  //     if (colorQtyMap != null &&
  //         colorQtyMap.values.any((qty) => qty != null && qty > 0)) {
  //       return false; // Return false if at least one color has quantity greater than 0
  //     }
  //   }

  //   return true; // Return true if all sizes have zero quantities for their colors
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: (getScreenWidth(context) / 2) - 5,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey[200]!),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            elevation: 2,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: (getScreenWidth(context) / 2) - 10,
                  height: getScreenHeight(context) / 3.3,
                  child: Image.network(
                    widget.productModell.productImageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      log('Error loading image: $error');
                      return const Icon(
                        Icons.error,
                        size: 50,
                        color: Colors.red,
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Text(
                    widget.productModell.productTitle,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 0, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "JOD ",
                              style:
                                  DefaultTextStyle.of(context).style.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      )),
                          TextSpan(
                              text: widget.productModell.productPrice,
                              style:
                                  DefaultTextStyle.of(context).style.copyWith(
                                        fontWeight: FontWeight.bold,
                                      )),
                        ]),
                      ),
                      FloatingActionButton.extended(
                        splashColor: Colors.green[200],
                        onPressed: isLoading
                            ? null
                            : () async {
                                final Map<String, dynamic>? selectedMap =
                                    await _showBottomSheet(
                                        context, widget.productModell);

                                if (selectedMap != null) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await BlocProvider.of<ProductsCubit>(context)
                                      .addToCartFirebase(
                                          productId:
                                              widget.productModell.productId,
                                          qty: 1,
                                          colorAndSizeMap: selectedMap,
                                          context: context);

                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                        backgroundColor: Colors.grey[100],
                        label: isLoading
                            ? SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: Colors.blue[400],
                                  strokeWidth: 3,
                                ),
                              )
                            : const Icon(
                                Icons.add_shopping_cart_outlined,
                                color: Colors.black,
                                size: 18,
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.productModell.getTotalQuantity() == 0)
          Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.5),
                border: Border.all(color: Colors.grey[200]!),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              width: getScreenWidth(context),
              height: getScreenHeight(context),
              child: const Center(
                child: Text(
                  'انتهى من المخزون',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ),
      ],
    );
  }

// Function to display BottomSheet for selecting size and color
  Future<Map<String, dynamic>?> _showBottomSheet(
      BuildContext context, ProductModel productModell) {
    String? selectedSize;
    Color? selectedColor;

    return showModalBottomSheet<Map<String, dynamic>?>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: getScreenHeight(context) * .4,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'اختر المقاس واللون',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  // Step 1: Show sizes
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        productModell.sizeAndColorQtyMap.keys.length,
                        (index) => Container(
                          decoration: BoxDecoration(
                            color: selectedSize ==
                                    productModell.sizeAndColorQtyMap.keys
                                        .elementAt(index)
                                ? Colors.blue[300]!
                                : Colors.grey[50],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedSize = productModell
                                    .sizeAndColorQtyMap.keys
                                    .elementAt(index);
                                selectedColor =
                                    null; // Reset color on size change
                              });
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Center(
                              child: Text(
                                'Size: ${productModell.sizeAndColorQtyMap.keys.elementAt(index)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Step 2: Show colors for the selected size (if any)
                  if (selectedSize != null) ...[
                    const Text(
                      'الألوان المتاحة',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          productModell
                              .sizeAndColorQtyMap[selectedSize]!.keys.length,
                          (index) {
                            Color color = productModell
                                .sizeAndColorQtyMap[selectedSize]!.keys
                                .elementAt(index);
                            int qty = productModell
                                    .sizeAndColorQtyMap[selectedSize]![color] ??
                                0;
                            return Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(555),
                                border: Border.all(
                                    width: selectedColor == color ? 5 : 0,
                                    color: Colors.blue[300]!),
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: InkWell(
                                onTap: qty == 0
                                    ? null
                                    : () {
                                        setState(() {
                                          selectedColor = color;
                                        });
                                      },
                                borderRadius: BorderRadius.circular(10),
                                child: qty == 0
                                    ? FittedBox(
                                        child: Text(
                                          'نفذت \nالكمية',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: useWhiteForeground(color)
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                  const Spacer(),
                  // Step 3: Save button (only enabled if both size and color are selected)
                  ElevatedButton(
                    onPressed: (selectedSize != null && selectedColor != null)
                        ? () {
                            // Add the selected size and color to the cart

                            Navigator.pop(context, {
                              'size': selectedSize,
                              'color': selectedColor,
                            });
                          }
                        : null,
                    child: Text(
                      'أضف إلى السلة',
                      style: TextStyle(color: Colors.blue[400]!),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
