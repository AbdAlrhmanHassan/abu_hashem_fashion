import 'package:abu_hashem_fashion/core/data/models/user_address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String orderId;
  final String userId;
  final double totalPrice;
  final int quantity;
  final String orderStatus;
  final Timestamp orderDate;
  final UserAddressModel userAddressModel;

  OrderModel({
    required this.userAddressModel,
    required this.orderId,
    required this.userId,
    required this.totalPrice,
    required this.quantity,
    required this.orderStatus,
    required this.orderDate,
  });

  Map<String, dynamic> toMap() {
    return {
      "orderId": orderId,
      "userId": userId,
      "totalPrice": totalPrice,
      "quantity": quantity,
      "orderStatus": orderStatus,
      "orderDate": orderDate,
      "userAddress": userAddressModel.toMap(),
    };
  }

  factory OrderModel.fromJson(DocumentSnapshot data) {
    return OrderModel(
      userAddressModel: UserAddressModel.fromMap(data["userAddress"]),
      orderId: data["orderId"],
      userId: data["userId"],
      totalPrice: data["totalPrice"],
      quantity: data["quantity"],
      orderStatus: data["orderStatus"],
      orderDate: data["orderDate"],
    );
  }
}
