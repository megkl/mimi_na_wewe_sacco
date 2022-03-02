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
  String? userAdmin;

  UserEntity(
      {String? id,
      this.userName,
      this.userPassword,
      this.userRegistrationType,
      this.userEmail,
      this.userPhoneNumber,
      this.userSocialId,
      this.userLocation,
      this.userAdmin})
      : super(id!);

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json["_id"],
        userName: json["username"],
        userPassword: json["password"],
        userPhoneNumber: json["phone_number"],
        userEmail: json["email_address"],
        userRegistrationType: json["registration_type"],
        userSocialId: json["social_use_id"],
        userLocation: json["user_userLocation"],
        userAdmin: json["is_user_admin"],
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
      "is_user_admin": userAdmin
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
        userAdmin.toString(),
        userLocation.toString()
      ];
}
