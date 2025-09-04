import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/models/product_model.dart';
import '../../../../../core/data/models/user_address_model.dart';
import '../../../data/cart_model.dart';
import '../../../data/order_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final produtDB = FirebaseFirestore.instance.collection("products");
  final usersDB = FirebaseFirestore.instance.collection("users");
  final ordersDB = FirebaseFirestore.instance.collection("orders");

  List<CartModel> _cartListV = [];
  List<ProductModel> _productsList = [];

  List<CartModel> get getCartList {
    return _cartListV;
  }

  List<ProductModel> get getProductsList {
    return _productsList;
  }

  Stream<int> getAllCartItemsQuantityStream() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.value(0); // Return 0 if no user is logged in
    }

    return usersDB.doc(user.uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        List<dynamic> cartItems = snapshot.get('userCart') ?? [];
        List<CartModel> cartList = cartItems.map((item) {
          return CartModel.fromJson(item);
        }).toList();
        _cartListV = cartList;
        int totalQuantity = 0;

        // Iterate through cartItems to sum the quantities
        for (CartModel item in cartList) {
          // Assuming each item has a quantity field
          totalQuantity += item.quantity; // Adjust based on your data structure
        }

        return totalQuantity; // Return the total quantity of items
      } else {
        return 0; // User document doesn't exist, return 0
      }
    });
  }

  int getAllCartItemsQuantity() {
    int totalQuantity = 0;
    for (var cartItem in _cartListV) {
      totalQuantity += cartItem.quantity;
    }
    return totalQuantity;
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

  double getAllCartItemsPrice() {
    double totalPrice = 0.0;

    if (_cartListV.isEmpty) {
      usersDB.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
        List<dynamic> cartItems = value.get('userCart') ?? [];
        _cartListV = cartItems.map((item) {
          return CartModel.fromJson(item);
        }).toList();
      });
    }

    try {
      emit(CartLoading());

      for (var cartItem in _cartListV) {
        final ProductModel product = _productsList.firstWhere(
          (product) => product.productId == cartItem.productId,
        );

        totalPrice += (double.parse(product.productPrice) * cartItem.quantity);

        emit(CartSuccess());
      }
      return totalPrice;
    } catch (e) {
      emit(CartFailure(errorMsg: e.toString()));
      rethrow;
    }
  }

  Future<void> deleteCartItemByProductId({
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

      // Find the index of the item to remove by productId
      final cartItemIndex =
          cartItems.indexWhere((item) => item['productId'] == productId);

      // If the item exists, remove it from the cart
      if (cartItemIndex != -1) {
        cartItems.removeAt(cartItemIndex);
        // Update Firestore with the new cart
        await usersDB.doc(user.uid).update({
          "userCart": cartItems,
        });
        _cartListV.removeWhere((cartItem) =>
            cartItem.productId == productId); // Update local cart list
        emit(CartSuccess());
      } else {
        throw Exception('Item not found in cart');
      }
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

  Future<void> addOrder({
    required UserAddressModel userAddressModel,
    required double deliveryPrice,
    required String orderId,
  }) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(const CartFailure(errorMsg: "User not authenticated"));
      return;
    }
    try {
      emit(CartLoading());

      final userDoc = await usersDB.doc(user.uid).get();
      List<dynamic> cartItems = await userDoc.get('userCart') ?? [];
      if (_cartListV.isEmpty) {
        _cartListV = cartItems.map((item) {
          return CartModel.fromJson(item);
        }).toList();
      }

      int totalQty = 0;

      for (var cartItem in _cartListV) {
        totalQty += cartItem.quantity;
      }

      // Create the order model
      OrderModel order = OrderModel(
        userAddressModel: userAddressModel,
        orderId: orderId,
        userId: user.uid,
        totalPrice: getAllCartItemsPrice() + deliveryPrice,
        quantity: totalQty,
        orderStatus: "جاري التجهيز",
        orderDate: Timestamp.now(),
      );

      // Add the order to the orders collection
      await ordersDB.doc(orderId).set(order.toMap());

      for (var cartItem in _cartListV) {
        // Add each cart item to the orderItems subcollection
        await ordersDB
            .doc(orderId)
            .collection('orderItems')
            .add(cartItem.toJson());

        // Convert the cart item to CartModel
        final CartModel cartModel = CartModel.fromJson(cartItem.toJson());
        final productId = cartModel.productId;
        final quantityPurchased = cartModel.quantity;

        // Fetch the product document from Firestore
        DocumentSnapshot productDoc = await produtDB.doc(productId).get();
        if (productDoc.exists) {
          // Fetch the overall product quantity and update it
          int currentQty = int.parse(productDoc.get('productQuantity'));
          int updatedQty = currentQty - quantityPurchased;
          if (updatedQty < 0) updatedQty = 0;

          // Update the overall product quantity in Firestore
          await produtDB.doc(productId).update({
            'productQuantity': updatedQty.toString(),
          });

          // Fetch the size and color map from Firestore
          Map<String, dynamic>? sizeAndColorMap =
              productDoc.get('sizeAndColorQtyMap') as Map<String, dynamic>?;

          // Loop through the size and color map entries
          for (MapEntry<String, dynamic> entry in sizeAndColorMap!.entries) {
            String size = entry.key;
            Map<String, dynamic> colorQtyMap =
                entry.value as Map<String, dynamic>;

            if (size == cartModel.sizeAndColorMap['size']) {
              var selectedColor = cartModel.sizeAndColorMap['color'];

              // Convert to integer if needed
              if (selectedColor is Color) {
                selectedColor = selectedColor.value;
              }

              // Update the correct color in the map
              if (colorQtyMap.containsKey(selectedColor.toString())) {
                int currentColorQty = colorQtyMap[selectedColor.toString()];
                int updatedColorQty = currentColorQty - quantityPurchased;
                if (updatedColorQty < 0) updatedColorQty = 0;

                // Update Firestore for the nested field directly
                await produtDB.doc(productId).update({
                  'sizeAndColorQtyMap.$size.$selectedColor': updatedColorQty,
                });

                log("Updated $size - $selectedColor quantity to $updatedColorQty");
                break;
              }
            }
          }
        }
      }

      // Clear the user's cart after order completion
      await usersDB.doc(user.uid).update({'userCart': []});
      _cartListV.clear();
      emit(CartSuccess()); // Emit success state
    } catch (e) {
      emit(CartFailure(errorMsg: e.toString()));
      log('Error in addOrder: $e');
    }
  }

  Future<void> fetchCartItems() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(const CartFailure(errorMsg: "User not authenticated"));
      return;
    }
    try {
      emit(CartLoading());
      final userDoc = await usersDB.doc(user.uid).get();
      List<dynamic> cartItems = userDoc.get('userCart') ?? [];
      _cartListV.clear();
      for (var item in cartItems) {
        _cartListV.add(CartModel.fromJson(item));
      }
      log('usercart lenght: ${_cartListV.length}');
      emit(CartSuccess());
    } catch (e) {
      emit(CartFailure(errorMsg: e.toString()));
    }
  }

  bool isProductInCart({required String productId}) {
    return _cartListV.any((cartItem) => cartItem.productId == productId);
  }

  Future<double?> getDeliveryPrice({required String governorate}) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('deliveryPrices')
          .doc('prices')
          .get();

      if (snapshot.exists) {
        // Assuming the document contains a map of governorates and prices
        final data =
            Map<String, dynamic>.from(snapshot.data() as Map<String, dynamic>);

        // Return the price for the given governorate, or null if not found
        return data[governorate]?.toDouble();
      } else {
        return null; // Document doesn't exist
      }
    } catch (e) {
      log('Error fetching delivery price: $e');

      return null; // Return null in case of an error
    }
  }

  Future<OrderModel> getOrderDetails({required String orderId}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('orders')
          .doc(orderId)
          .get();
      log('user doc ${snapshot.data() == null}');
      log('snapshot exists: ${snapshot.id}');
      return OrderModel.fromJson(snapshot);
    } catch (e) {
      log('Error fetching order details: $e');
      rethrow;
    }
  }
}
