import 'dart:developer';

import 'package:abu_hashem_fashion/features/cart/data/cart_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/data/models/product_model.dart';

part 'view_all_products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ViewAllProductsInitial());

  final produtDB = FirebaseFirestore.instance.collection("products");
  final userDB = FirebaseFirestore.instance.collection("users");

  List<ProductModel> _productsList = [];

  List<ProductModel> get getProducts {
    return _productsList;
  }

  Future<void> fetchProducts() async {
    try {
      emit(ViewAllProductsLoading()); // Emit a loading state if needed

      // Fetch the data only once
      final productsSnapshot = await produtDB.orderBy("createAt").get();

      _productsList.clear(); // Clear the list before adding new data
      for (var element in productsSnapshot.docs) {
        _productsList.insert(0, ProductModel.fromFirestore(element));
      }

      emit(ViewAllProductsSuccess(
          productModel: _productsList)); // Emit success with the updated list
    } catch (e) {
      emit(ViewAllProductsFailure(errorMsg: e.toString()));
      rethrow;
    }
  }

  Stream<List<ProductModel>> get productsStream {
    return FirebaseFirestore.instance
        .collection('products')
        .orderBy('createAt', descending: true) // Ensure ordering
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ProductModel.fromFirestore(doc))
              .where((product) =>
                  product.getTotalQuantity() >
                  0) // Filter out products with qty 0
              .take(30) // Take only the first 30 products after filtering
              .toList(),
        );
  }

  Future<void> addToCartFirebase({
    required String productId,
    required int qty,
    required Map<String, dynamic> colorAndSizeMap,
    required BuildContext context,
  }) async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      emit(const CartFailure(errorMsg: "User not authenticated"));
      return;
    }

    try {
      emit(ViewAllProductsLoading());

      // Check if the product exists in the product database
      final productDoc = await produtDB.doc(productId).get();
      if (productDoc.exists == false) {
        // First emit the state change
        emit(const CartFailure(errorMsg: "هذا المنتج غير موجود"));

        // Then show the SnackBar

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('هذا المنتج غير موجود'),
            backgroundColor: Colors.red,
          ),
        );

        fetchProducts(); // Fetch products after error
        return;
      }

      // Fetch the current cart data
      final userDoc = await userDB.doc(user.uid).get();
      List<dynamic> userCart = userDoc.get('userCart') ?? [];

      // Check if the product is already in the cart
      bool productExists = false;
      List<Map<String, dynamic>> updatedCart = [];

      for (var item in userCart) {
        if (item['sizeAndColorMap']['size'] == colorAndSizeMap['size'] &&
            (item['sizeAndColorMap']['color'] as int) ==
                (colorAndSizeMap['color'] as Color).value) {
          log('product exists');
          updatedCart.add({
            "cartId": item['cartId'],
            "productId": productId,
            'sizeAndColorMap': {
              'size': colorAndSizeMap['size'],
              'color': (colorAndSizeMap['color'] as Color)
                  .value, // Store color as an integer
            },
            "productQuantity": item['productQuantity'] + qty,
          });
          productExists = true;
        } else {
          // Add existing items to updated list
          updatedCart.add(item);
        }
      }
      CartModel cartModel = CartModel(
        productId: productId,
        quantity: qty,
        sizeAndColorMap: colorAndSizeMap,
        cartId: const Uuid().v4(),
      );
      if (!productExists) {
        // Product does not exist, add a new item
        updatedCart.add(cartModel.toJson());
      }

      // Update the cart in Firestore
      await userDB.doc(user.uid).update({
        'userCart': updatedCart,
      });

      // Emit success state
      emit(ViewAllProductsLoading());

      // Show success SnackBar after successful addition to cart
      // if (context.mounted) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: const Text('Product added to cart successfully!'),
      //     backgroundColor: Colors.green,
      //   ),
      // );
      // }
    } catch (e) {
      // Emit failure state
      emit(CartFailure(errorMsg: e.toString()));
      log('error in add to cart $e');

      // Show error SnackBar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding product to cart: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<List<ProductModel>?> searchForProduct(
      {String? productTitle, String? categores}) async {
    emit(ViewAllProductsLoading());
    try {
      if (_productsList.isEmpty) {
        QuerySnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance.collection('products').get();

        _productsList = snapshot.docs
            .map((doc) => ProductModel.fromFirestore(doc))
            .toList();
      }
      List<ProductModel> matchedProducts = [];
      if (productTitle != null) {
        matchedProducts = [];
        for (ProductModel element in _productsList) {
          if (element.productTitle
              .toLowerCase()
              .contains(productTitle.toLowerCase())) {
            matchedProducts.add(element);
          }
        }
      }

      if (categores != null) {
        matchedProducts = [];

        for (ProductModel element in _productsList) {
          if (element.productCategory == categores) {
            matchedProducts.add(element);
          }
        }
      }

      if (matchedProducts.isNotEmpty) {
        return matchedProducts;
      }

      emit(ViewAllProductsSuccess(productModel: _productsList));

      // return _productsList;
    } catch (e) {
      emit(CartFailure(errorMsg: e.toString()));
      return [];
    }
    return null;
  }
}
