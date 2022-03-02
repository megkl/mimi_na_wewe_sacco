import 'package:flutter/material.dart';
import 'package:mimi_na_wewe_sacco/data/repository/user/user_repository.dart';
import 'package:mimi_na_wewe_sacco/domain/model/profile_entity.dart';
import 'package:mimi_na_wewe_sacco/domain/model/user_entity.dart';
import 'user_api_handler.dart';

class UserRepositoryImpl extends UserRepository {
  final UserApiHandler? userApiHandler;

  UserRepositoryImpl({this.userApiHandler});

  @override
  Future<void> signIn(
      {String? email, String? phoneNumber, String? signInWith}) async {
    return userApiHandler!
        .signIn(email: email, phoneNumber: phoneNumber, signInWith: signInWith);
  }

  @override
  Future<void> signUp(
      {String? email, String? phoneNumber, String? signUpWith}) async {
    return userApiHandler!
        .signUp(email: email, phoneNumber: phoneNumber, signUpWith: signUpWith);
  }

  @override
  Future<UserEntity> getUser() async {
    try {
      return userApiHandler!.getUser();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> resendCode({String? email, String? phoneNumber}) async {
    return userApiHandler!.resendCode(email: email, phoneNumber: phoneNumber);
  }

  @override
  Future<void> resetCode({String? email, String? phoneNumber}) {
    // TODO: implement resetCode
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> codeVerification({String? code}) {
    return userApiHandler!.codeVerification(code: code);
  }

  @override
  Future<void> updateProfile(
      {String? firstName,
      String? middleName,
      String? lastName,
      String? email,
      String? phoneNumber,
      String? idNumber,
      bool? isAdmin,
      String? country}) {
    return userApiHandler!.updateProfile(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        idNumber: idNumber,
        isAdmin: isAdmin,
        email: email,
        phoneNumber: phoneNumber,
        country: country);
  }

  @override
  Future<void> setUserPin({String? pin}) {
    return userApiHandler!.setUserPin(pin: pin);
  }

  @override
  Future<void> logout({String? refreshToken}) {
    return userApiHandler!.logout(refreshToken: refreshToken);
  }

  @override
  Future<void> enterUserPin({String? pin, String? id}) {
    // TODO: implement enterUserPin
    return userApiHandler!.enterUserPin(pin: pin, id: id);
  }

  @override
  Future<ProfileEntity> fetchProfile() {
    return userApiHandler!.fetchProfile();
  }

  @override
  Future<Map<String, dynamic>> refreshToken({String? refreshToken}) {
    return userApiHandler!.refreshToken(refreshToken: refreshToken);
  }
}
