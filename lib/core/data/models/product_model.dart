import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductModel {
  // Existing fields
  Timestamp? createdAt;
  final String productId,
      productImageUrl,
      productCategory,
      productTitle,
      productPrice,
      productDescription;
  final Map<String, Map<Color, int?>?> sizeAndColorQtyMap;

  ProductModel({
    required this.createdAt,
    required this.productId,
    required this.productImageUrl,
    required this.productCategory,
    required this.productTitle,
    required this.productPrice,
    required this.productDescription,
    required this.sizeAndColorQtyMap,
  });

  // Factory method for creating a ProductModel instance from Firestore
  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Parse sizeAndColorQtyMap from Firestore
    Map<String, Map<Color, int?>?> parsedSizeAndColorQtyMap = {};
    if (data['sizeAndColorQtyMap'] != null) {
      Map<String, dynamic> rawMap = data['sizeAndColorQtyMap'];

      rawMap.forEach((size, colorQtyMap) {
        Map<Color, int?> parsedColorMap = {};
        if (colorQtyMap != null) {
          Map<String, dynamic> colorMap = colorQtyMap as Map<String, dynamic>;
          colorMap.forEach((colorString, qty) {
            // Convert color from Firestore int (ARGB) to Color object
            Color color = Color(int.parse(colorString));
            parsedColorMap[color] = qty;
          });
        }
        parsedSizeAndColorQtyMap[size] = parsedColorMap;
      });
    }

    return ProductModel(
      createdAt: data["createAt"],
      productId: data["productId"],
      productCategory: data["productCategory"],
      productImageUrl: data["productImage"],
      productTitle: data["productTitle"],
      productPrice: data["productPrice"],
      productDescription: data["productDescription"],
      sizeAndColorQtyMap: parsedSizeAndColorQtyMap,
    );
  }

  // Method to calculate the total quantity from sizeAndColorQtyMap
  int getTotalQuantity() {
    int totalQty = 0;
    sizeAndColorQtyMap.forEach((size, colorQtyMap) {
      colorQtyMap?.forEach((color, qty) {
        totalQty += qty ?? 0; // Sum up quantities, ignoring null values
      });
    });
    return totalQty;
  }

  // Method to convert ProductModel to a Map for saving to Firestore
  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> sizeAndColorQtyMapForFirestore = {};

    sizeAndColorQtyMap.forEach((size, colorQtyMap) {
      Map<String, int?> colorMapForFirestore = {};
      if (colorQtyMap != null) {
        colorQtyMap.forEach((color, qty) {
          // Convert Color object to int for Firestore (ARGB)
          colorMapForFirestore[color.value.toString()] = qty;
        });
      }
      sizeAndColorQtyMapForFirestore[size] = colorMapForFirestore;
    });

    return {
      "createAt": createdAt,
      "productId": productId,
      "productCategory": productCategory,
      "productImage": productImageUrl,
      "productTitle": productTitle,
      "productPrice": productPrice,
      "productDescription": productDescription,
      "sizeAndColorQtyMap": sizeAndColorQtyMapForFirestore,
    };
  }
}
