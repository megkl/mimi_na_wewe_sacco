import 'package:flutter/material.dart';
import 'package:mimi_na_wewe_sacco/data/repository/user/user_repository.dart';
import 'package:mimi_na_wewe_sacco/domain/model/profile_entity.dart';
import 'package:mimi_na_wewe_sacco/domain/model/user_entity.dart';
import 'user_api_handler.dart';

class UserRepositoryImpl extends UserRepository {
  final UserApiHandler? userApiHandler;

  UserRepositoryImpl({this.userApiHandler});

  @override
  Future<String> signIn({
    String? username,
    String? phoneNumber,
    String? emailAddress,
    String? password,
    bool? isVerified,
    bool? isAdmin,
    String? userLocation,
  }) async {
    return userApiHandler!.signIn(
        emailAddress: emailAddress,
        phoneNumber: phoneNumber,
        username: username,
        password: password,
        isAdmin: isAdmin,
        isVerified: isVerified,
        userLocation: userLocation);
  }

  @override
  Future<String> signUp(
      {String? username,
      String? phoneNumber,
      String? emailAddress,
      String? password,
      String? registrationType,
      String? socialId,
      bool? isVerified,
      bool? isAdmin,
      String? location}) async {
    return userApiHandler!.signUp(
        emailAddress: emailAddress,
        phoneNumber: phoneNumber,
        registrationType: registrationType,
        location: location,
        password: password,
        socialId: socialId,
        isAdmin: isAdmin,
        isVerified: isVerified,
        username: username);
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
      String? username,
      String? lastName,
      String? email,
      String? phoneNumber,
      String? idNumber,
      bool? isAdmin,
      bool? isActive,
      String? location}) {
    return userApiHandler!.updateProfile(
        firstName: firstName,
        middleName: middleName,
        username: username,
        lastName: lastName,
        idNumber: idNumber,
        isAdmin: isAdmin,
        isActive: isActive,
        email: email,
        phoneNumber: phoneNumber,
        location: location);
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
  Future<ProfileEntity> fetchProfile(String? username) {
    return userApiHandler!.fetchProfile(username);
  }

  @override
  Future<Map<String, dynamic>> refreshToken({String? refreshToken}) {
    return userApiHandler!.refreshToken(refreshToken: refreshToken);
  }
}
