import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      await produtDB.orderBy("createdAt").get().then((productsSnapshot) {
        _productsList.clear();
        for (var element in productsSnapshot.docs) {
          _productsList.insert(0, ProductModel.fromFirestore(element));
        }
      });
      emit(ViewAllProductsSuccess(productModel: _productsList));
    } catch (e) {
      emit(ViewAllProductsFailure(errorMsg: e.toString()));
      rethrow;
    }
  }

  Future<void> addToCartFirebase(
      {required String productId, required int qty}) async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      emit(const CartFailure(errorMsg: "User not authenticated"));
      return;
    }

    try {
      emit(CartLoading());

      // Fetch the current cart data
      final userDoc = await userDB.doc(user.uid).get();
      List<dynamic> userCart = userDoc.get('userCart') ?? [];

      // Check if the product is already in the cart
      bool productExists = false;
      List<Map<String, dynamic>> updatedCart = [];

      for (var item in userCart) {
        if (item['productId'] == productId) {
          updatedCart.add({
            "cartId": item['cartId'],
            "productId": productId,
            "productQuantity": item['productQuantity'] + qty,
          });
          productExists = true;
        } else {
          // Add existing items to updated list
          updatedCart.add(item);
        }
      }

      if (!productExists) {
        // Product does not exist, add a new item
        final cartId = const Uuid().v4();
        updatedCart.add({
          "cartId": cartId,
          "productId": productId,
          "productQuantity": qty,
        });
      }

      // Update the cart in Firestore
      await userDB.doc(user.uid).update({
        'userCart': updatedCart,
      });

      emit(CartAddSuccess());
    } catch (e) {
      emit(CartFailure(errorMsg: e.toString()));
    }
  }

  Future<List<ProductModel>> searchForProduct(
      {required String productTitle}) async {
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

      for (ProductModel element in _productsList) {
        if (element.productTitle
            .toLowerCase()
            .contains(productTitle.toLowerCase())) {
          matchedProducts.add(element);
        }
      }

      if (matchedProducts.isNotEmpty) {
        return matchedProducts;
      }

      emit(ViewAllProductsSuccess(productModel: _productsList));

      return _productsList;
    } catch (e) {
      emit(CartFailure(errorMsg: e.toString()));
      return [];
    }
  }
}
