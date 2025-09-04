import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId, userName, phone, userEmail;

  final Timestamp createdAt;
  final List userCart;
  final List? userWish;

  UserModel({
    required this.userId,
    required this.userName,
    required this.phone,
    required this.userEmail,
    required this.userCart,
    required this.createdAt,
    this.userWish,
  });


  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "userName": userName,
      "userPhone": phone,
      "userEmail": userEmail,
      "userCart": userCart,
      "createAt": createdAt,
      "userWish": userWish,
    };
  }



  factory UserModel.json(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      userName: map['userName'],
      phone: map['userPhone'],
      userEmail: map['userEmail'],
      userCart: map['userCart'],
      createdAt: map['createAt'],
      userWish: map['userWish'],
    );
  }
}
