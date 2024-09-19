import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/models/product_model.dart';
import '../../../data/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final produtDB = FirebaseFirestore.instance.collection("products");
  final usersDB = FirebaseFirestore.instance.collection("users");

  List<CartModel> _cartListV = [];
  List<ProductModel> _productsList = [];

  List<CartModel> get getCartList {
    return _cartListV;
  }

  List<ProductModel> get getProductsList {
    return _productsList;
  }

  Stream<List<ProductModel>>? getCartRealTimeData() {
    emit(CartLoading());
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return Stream.error("User not found");
      }

      return usersDB.doc(user.uid).snapshots().asyncMap((userDoc) async {
        List<dynamic> cartItems = userDoc.get('userCart') ?? [];
        List<CartModel> cartList = cartItems.map((item) {
          return CartModel.fromJson(item);
        }).toList();
        _cartListV = cartList;
        if (cartList.isEmpty) {
          return [];
        }

        List<String> productIds =
            cartList.map((cartItem) => cartItem.productId).toList();

        // Switch to real-time snapshots for products
        QuerySnapshot productsSnapshot = await produtDB
            .where(FieldPath.documentId, whereIn: productIds)
            .snapshots()
            .first; // Ensure you listen for updates

        List<ProductModel> productsList = productsSnapshot.docs
            .map((doc) => ProductModel.fromFirestore(doc))
            .toList();

        emit(CartSuccess());
        _productsList = productsList;
        return productsList;
      });
    } catch (e) {
      emit(CartFailure(errorMsg: e.toString()));
      return Stream.error(e.toString());
    }
  }

  int getAllCartItemsQuantity() {
    int totalQuantity = 0;
    for (var cartItem in _cartListV) {
      totalQuantity += cartItem.quantity;
    }
    return totalQuantity;
  }

  double? getAllCartItemsPrice() {
    double totalPrice = 0.0;
    try {
      emit(CartLoading());
      log('getAllCartItemsPrice: ${_cartListV.length}');
      log('getAllCartItemsPrice: ${_productsList.length}');
      for (var cartItem in _cartListV) {
        final product = _productsList.firstWhere(
          (product) => product.productId == cartItem.productId,
        );
        if (product != null) {
          totalPrice +=
              (double.parse(product.productPrice) * cartItem.quantity);
        }
        emit(CartSuccess());
      }
      return totalPrice;
    } catch (e) {
      emit(CartFailure(errorMsg: e.toString()));
      return null;
    }
  }

  Future<void> deleteCartItem({
    required String cartId,
    required String productId,
  }) async {
    try {
      emit(CartLoading());

      // Fetch current user
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not authenticated");

      // Get the user's cart document
      final userDoc = await usersDB.doc(user.uid).get();
      List<dynamic> cartItems = userDoc.get('userCart') ?? [];

      // Find the index of the item to remove
      final cartItemIndex = cartItems.indexWhere(
          (item) => item['cartId'] == cartId && item['productId'] == productId);

      // If the item exists, remove it from the cart
      if (cartItemIndex != -1) {
        cartItems.removeAt(cartItemIndex);
      } else {
        throw Exception('Item not found in cart');
      }

      // Update Firestore with the new cart
      await usersDB.doc(user.uid).update({
        "userCart": cartItems,
      });

      emit(CartSuccess());
    } catch (e) {
      emit(CartFailure(errorMsg: e.toString()));
    }
  }

  Future<void> quantityChange({
    required String cartId,
    required int qty,
    required String productId,
  }) async {
    emit(CartLoading());
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      emit(const CartFailure(errorMsg: "User not authenticated"));
      return;
    }

    try {
      // Get the current userCart from Firestore
      final userDoc = await usersDB.doc(user.uid).get();
      List<dynamic> cartItems = userDoc.get('userCart') ?? [];

      // Find the index of the cart item to modify
      final cartItemIndex = cartItems.indexWhere(
        (item) => item['cartId'] == cartId && item['productId'] == productId,
      );

      if (cartItemIndex == -1) {
        throw Exception("Cart item not found");
      }

      // Clone the cart item to modify
      Map<String, dynamic> cartItem =
          Map<String, dynamic>.from(cartItems[cartItemIndex]);

      // Update the quantity
      cartItem['productQuantity'] = qty;

      // Replace the cart item in the array
      cartItems[cartItemIndex] = cartItem;

      // Update Firestore with the modified cartItems array
      await usersDB.doc(user.uid).update({
        "userCart": cartItems,
      });

      emit(CartSuccess());
    } catch (e) {
      emit(CartFailure(errorMsg: e.toString()));
    }
  }

  Future<int> checkProductQuantity({required String productId}) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(const CartFailure(errorMsg: "User not authenticated"));
    }
    try {
      DocumentSnapshot productDoc = await produtDB.doc(productId).get();

      ProductModel product = ProductModel.fromFirestore(productDoc);
      return int.parse(product.productQuantity);
    } catch (e) {
      emit(CartFailure(errorMsg: e.toString()));
      rethrow;
    }
  }
}
