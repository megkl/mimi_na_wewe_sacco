import 'package:flutter/material.dart';
import 'package:mimi_na_wewe_sacco/domain/model/profile_entity.dart';
import 'package:mimi_na_wewe_sacco/domain/model/user_entity.dart';

abstract class UserRepository {
  /// an access token as [String]
  Future<String> signIn({
    String? username,
    String? phoneNumber,
    String? emailAddress,
    String? password,
    bool? isVerified,
    bool? isAdmin,
    String? userLocation,
  });

  Future<String> signUp(
      {String? username,
      String? phoneNumber,
      String? emailAddress,
      String? password,
      String? registrationType,
      String? socialId,
      bool? isVerified,
      bool? isAdmin,
      String? location});

  Future<Map<String, dynamic>> codeVerification({String? code});

  Future<void> logout({String? refreshToken});

  Future<void> resendCode({String? email, String? phoneNumber});

  Future<Map<String, dynamic>> refreshToken({String? refreshToken});

  Future<void> updateProfile(
      {String? firstName,
      String? middleName,
      String? username,
      String? lastName,
      String? email,
      String? phoneNumber,
      String? idNumber,
      bool? isAdmin,
      bool? isActive,
      String? location});

  Future<void> setUserPin({String? pin});

  Future<void> enterUserPin({String? pin, String? id});

  // /// Get the user information and return it as [AppUser]
  Future<UserEntity> getUser();

  Future<ProfileEntity> fetchProfile(String? username);
}
