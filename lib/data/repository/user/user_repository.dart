import 'package:flutter/material.dart';
import 'package:mimi_na_wewe_sacco/domain/model/profile_entity.dart';
import 'package:mimi_na_wewe_sacco/domain/model/user_entity.dart';

abstract class UserRepository {
  /// an access token as [String]
  Future<void> signIn({String? email, String? phoneNumber, String? signInWith});

  Future<void> signUp({String? email, String? phoneNumber, String? signUpWith});

  Future<Map<String, dynamic>> codeVerification({String? code});

  Future<void> logout({String? refreshToken});

  Future<void> resendCode({String? email, String? phoneNumber});

  Future<Map<String, dynamic>> refreshToken({String? refreshToken});

  Future<void> updateProfile(
      {String? firstName,
      String? middleName,
      String? lastName,
      String? email,
      String? phoneNumber,
      String? idNumber,
      bool? isAdmin,
      String? country});

  Future<void> setUserPin({String? pin});

  Future<void> enterUserPin({String? pin, String? id});

  // /// Get the user information and return it as [AppUser]
  Future<UserEntity> getUser();

  Future<ProfileEntity> fetchProfile();
}
