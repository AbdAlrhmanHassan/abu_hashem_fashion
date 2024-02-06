import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId, userName, userEmail;
  final Timestamp createdAt;
  final List userCart;
  final List? userWish;

  UserModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userCart,
    required this.createdAt,
    this.userWish,
  });
}
