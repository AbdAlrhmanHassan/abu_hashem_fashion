import 'package:cloud_firestore/cloud_firestore.dart';

class UserAddressModel {
  String governorate;
  String city;
  String address;
  String? apartmentNumber;

  UserAddressModel({
    required this.governorate,
    required this.city,
    required this.address,
    required this.apartmentNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'governorate': governorate,
      'city': city,
      'address': address,
      'apartmentNumber': apartmentNumber,
    };
  }

  factory UserAddressModel.fromMap(Map<dynamic, dynamic> map) {
    return UserAddressModel(
      governorate: map['governorate'] ?? '',
      city: map['city'] ?? '',
      address: map['address'] ?? '',
      apartmentNumber: map['apartmentNumber'],
    );
  }
  factory UserAddressModel.fromJson(DocumentSnapshot doc) {
    return UserAddressModel(
      governorate: doc['governorate'] ?? '',
      city: doc['city'] ?? '',
      address: doc['address'] ?? '',
      apartmentNumber: doc['apartmentNumber'],
    );
  }
}
