import 'package:flutter/material.dart';

class CartModel {
  final String cartId;
  final String productId;
  final Map<String, dynamic> sizeAndColorMap; // We store size and color as map
  final int quantity;

  CartModel({
    required this.cartId,
    required this.productId,
    required this.sizeAndColorMap,
    required this.quantity,
  });

  // Convert CartModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'cartId': cartId,
      'productId': productId,
      'sizeAndColorMap': {
        'size': sizeAndColorMap['size'],
        'color': (sizeAndColorMap['color'] as Color)
            .value, // Store color as an integer
      },
      'productQuantity': quantity,
    };
  }

  // Create CartModel from JSON
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartId: json['cartId'],
      productId: json['productId'],
      sizeAndColorMap: {
        'size': json['sizeAndColorMap']['size'],
        'color': Color(
            json['sizeAndColorMap']['color']), // Convert back to Color from int
      },
      quantity: json['productQuantity'],
    );
  }
}
