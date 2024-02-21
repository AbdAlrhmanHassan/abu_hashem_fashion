
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/data/models/product_model.dart';
import '../../../data/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  final User? user = FirebaseAuth.instance.currentUser;

  final Map<String, CartModel> cartItems = {};

  final userDB = FirebaseFirestore.instance.collection("users");

  final produtDB = FirebaseFirestore.instance.collection("products");
  List<CartModel> _cartList = [];

  List<CartModel> get getCartList {
    return _cartList;
  }

  List<ProductModel> productsList = [];
  List<ProductModel> productsInCartList = [];

  Future<void> addToCartFirebase(
      {required String productId, required int qty}) async {
    final uid = user!.uid;
    final cartId = const Uuid().v4();

    try {
      emit(CartLoading());
      userDB.doc(uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            "cartId": cartId,
            "productId": productId,
            "productQuantity": qty,
          }
        ])
      });
      fetchCart();
    } catch (e) {
      emit(CartFailure(errorMsg: e.toString()));
    }
  }

  Future<void> fetchCart() async {
    try {
      emit(CartLoading());
      final userDoc = await userDB.doc(user!.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey("userCart")) {
        emit(const CartFailure(
            errorMsg:
                "Cart data not found")); // Provide descriptive error message
        return;
      }
      final userCart = data["userCart"] as List<dynamic>; // Store userCart data
      for (int i = 0; i < userCart.length; i++) {
        final cartItem =
            userCart[i] as Map<String, dynamic>; // Store current cart item data

        cartItems.putIfAbsent(
          cartItem["productId"] as String,
          () => CartModel(
            cartId: cartItem["cartId"] as String,
            productId: cartItem["productId"] as String,
            quantity: cartItem["productQuantity"] as int,
          ),
        );
      }
      _cartList = cartItems.values.toList();
      emit(CartSuccess(cartItems.values.toList())); // Emit list of cart items
    } catch (e) {
      emit(
          CartFailure(errorMsg: e.toString())); // Handle and emit failure state
    }
  }
}
