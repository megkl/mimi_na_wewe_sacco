import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mimi_na_wewe_sacco/config/server_address.dart';
import 'package:mimi_na_wewe_sacco/config/storage.dart';
import 'package:mimi_na_wewe_sacco/data/repository/user/user_repository.dart';
import 'package:mimi_na_wewe_sacco/domain/model/profile_entity.dart';
import 'package:mimi_na_wewe_sacco/domain/model/user_entity.dart';

import '../utils.dart';

class UserApiHandler extends UserRepository {
  @override
  Future<String> signIn(
      {String? username,
      String? phoneNumber,
      String? emailAddress,
      String? password,
      bool? isVerified,
      bool? isAdmin,
      String? userLocation}) async {
    var route = HttpClient().createUri(ServerAddresses.login);
    var headers = HttpClient().createHeader();

    var data = <String, dynamic>{
      "username": username,
      "password": password,
    };
    var body = json.encode(data);
    var response = await http.post(route, body: body, headers: headers);
    Map jsonResponse = json.decode(response.body);
    if (jsonResponse['Status'] != 200) {
      throw jsonResponse['msg'];
    }
    await Storage()
        .secureStorage
        .write(key: 'token', value: jsonResponse['token']);
    return jsonResponse['token'];
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
    try {
      var route = HttpClient().createUri(ServerAddresses.register);
      var headers = HttpClient().createHeader();
      var data = <String, dynamic>{
        "username": username,
        "password": password,
        "email_address": emailAddress,
        "phone_number": phoneNumber,
        "is_admin": isAdmin,
        "is_verified": isVerified,
        "location": location,
        "registration_type": registrationType,
        "social_user_Id": socialId,
        "date_created": DateTime.now().toString()
      };
      print(data);
      var body = json.encode(data);
      var response = await http.post(route, headers: headers, body: body);
      Map jsonResponse = json.decode(response.body);
      if (jsonResponse['Status'] != 200) {
        throw jsonResponse['msg'];
      }
      await Storage()
          .secureStorage
          .write(key: 'token', value: jsonResponse['token']);
      return jsonResponse['token'];
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> getUser() async {
    try {
      // TODO api call for user information
      await Future.delayed(Duration(seconds: 2));

      return UserEntity();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> resendCode({String? email, String? phoneNumber}) async {
    try {
      var route = HttpClient().createUri(ServerAddresses.resendCode);
      var data = <String, String?>{
        'email_address': email,
        'phone_number': phoneNumber
      };

      var response = await http.post(route, body: data);
      Map jsonResponse = json.decode(response.body);
      if (response.statusCode != 200) {
        throw jsonResponse['message'];
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> updateProfile(
      {String? firstName,
      String? middleName,
      String? lastName,
      String? username,
      String? email,
      String? phoneNumber,
      String? idNumber,
      bool? isAdmin,
      bool? isActive,
      String? location}) async {
    try {
      Map<String, String> headers = {
        "Authorization": "Bearer ${Storage().token}"
      };
      var route = HttpClient()
          .createUri(ServerAddresses.updateProfile + username.toString());
      var data = <String, dynamic>{
        "user_first_name": firstName,
        "user_middle_name": middleName,
        "user_last_name": lastName,
        "location": location,
        "is_admin": isAdmin,
        "is_active": true,
        "identification_number": idNumber,
        "email_address": email,
        "phone_number": phoneNumber
      };
      var body = json.encode(data);
      var response = await http.put(route, body: body, headers: headers);
      Map jsonResponse = json.decode(response.body);
      if (response.statusCode != 200) {
        throw jsonResponse['message'];
      }
      // return jsonResponse['token'];
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> logout({String? refreshToken, String? userId}) async {
    try {
      var headers = HttpClient().createHeader();

      var data = <String, String?>{
        "_id": userId.toString(),
      };
      var body = jsonEncode(data);
      var route = HttpClient()
          .createUri(ServerAddresses.logout + refreshToken.toString());

      var response = await http.post(route, body: body, headers: headers);
      Map jsonResponse = json.decode(response.body);
      if (jsonResponse['status_code'] != 200) {
        throw jsonResponse['message'];
      }
      //return jsonResponse['token'];
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<ProfileEntity> fetchProfile(String? username) async {
    try {
      var headers = HttpClient().createHeader();

      var route = HttpClient()
          .createUri(ServerAddresses.getProfile + username.toString());

      var response = await http.get(route, headers: headers);
      Map jsonResponse = json.decode(response.body);
      ProfileEntity profile = ProfileEntity.fromJson(jsonResponse['data']);
      if (jsonResponse['Status'] != 200) {
        throw jsonResponse['message'];
      }
      return profile;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> codeVerification({String? code}) {
    // TODO: implement codeVerification
    throw UnimplementedError();
  }

  @override
  Future<void> enterUserPin({String? pin, String? id}) {
    // TODO: implement enterUserPin
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> refreshToken({String? refreshToken}) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<void> setUserPin({String? pin}) {
    // TODO: implement setUserPin
    throw UnimplementedError();
  }
}
