import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/data/models/product_model.dart';

part 'view_all_products_state.dart';

class ViewAllProductsCubit extends Cubit<ViewAllProductsState> {
  ViewAllProductsCubit() : super(ViewAllProductsInitial());

  final produtDB = FirebaseFirestore.instance.collection("products");
  final List<ProductModel> _productsList = [];
  List<ProductModel> get getProducts {
    return _productsList;
  }

  Future<List<ProductModel>> fetchProducts() async {
    try {
      _productsList.clear();

      await produtDB.orderBy("createdAt").get().then((productsSnapshot) {
        for (var element in productsSnapshot.docs) {
          _productsList.insert(0, ProductModel.fromFirestore(element));
        }
      });
      emit(ViewAllProductsSuccess(productModel: _productsList));
      return _productsList;
    } catch (e) {
      emit(ViewAllProductsFailure(errorMsg: e.toString()));

      rethrow;
    }
  }

  Future<ProductModel?>? findByProdId({required String productId}) async {
    await fetchProducts();
    log("find p b id : ${_productsList.length}");
    if (_productsList
        .where((element) => element.productId == productId)
        .isEmpty) {
      return null;
    }

    return _productsList
        .firstWhere((element) => element.productId == productId);
  }
}
