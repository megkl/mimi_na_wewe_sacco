import 'dart:convert';

import '../entity.dart';

class UserEntity extends Entity<String> {
  String? userName;
  String? userPassword;
  String? userRegistrationType;
  String? userEmail;
  String? userPhoneNumber;
  String? userSocialId;
  String? userLocation;
  bool? isAdmin;
  bool? isVerified;

  UserEntity(
      {String? id,
      this.userName,
      this.userPassword,
      this.userRegistrationType,
      this.userEmail,
      this.userPhoneNumber,
      this.userSocialId,
      this.userLocation,
      this.isVerified,
      this.isAdmin})
      : super(id!);

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json["_id"],
        userName: json["username"],
        userPassword: json["password"],
        userPhoneNumber: json["phone_number"],
        userEmail: json["email_address"],
        userRegistrationType: json["registration_type"],
        userSocialId: json["social_user_id"],
        userLocation: json["user_location"],
        isAdmin: json["is_admin"],
        isVerified: json["is_verified"],
      );
  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "username": userName,
      "password": userPassword,
      "email_address": userEmail,
      "user_phone_number": userPhoneNumber,
      "registration_type": userRegistrationType,
      "location": userLocation,
      "is_admin": isAdmin,
      "is_verified": isVerified
    };
  }

  @override
  List<Object> get props => [
        id,
        userName.toString(),
        userPassword.toString(),
        userEmail.toString(),
        userPhoneNumber.toString(),
        userRegistrationType.toString(),
        isAdmin.toString(),
        isVerified.toString(),
        userLocation.toString()
      ];
}
