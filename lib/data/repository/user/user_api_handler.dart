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
  Future<void> signIn({
    String? email,
    String? phoneNumber,
    String? signInWith,
  }) async {
    var route = HttpClient().createUri(ServerAddresses.login);
    var data = <String, String?>{
      "user_phone_number": phoneNumber,
      "user_email_address": email,
      "sign_in_with": signInWith
    };

    var response = await http.post(route, body: data);
    Map jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] != 200) {
      throw jsonResponse['message'];
    }
    // return jsonResponse['token'];
  }

  @override
  Future<void> signUp(
      {String? email, String? phoneNumber, String? signUpWith}) async {
    try {
      var route = HttpClient().createUri(ServerAddresses.register);
      var data = <String, String?>{
        "user_email_address": email,
        "user_phone_number": phoneNumber,
        "sign_up_with": signUpWith
      };

      var response = await http.post(route, body: data);
      Map jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] != 200) {
        throw jsonResponse['message'];
      }
      // return jsonResponse['token'];
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
      String? email,
      String? phoneNumber,
      String? idNumber,
      bool? isAdmin,
      String? country}) async {
    try {
      Map<String, String> headers = {
        "Authorization": "Bearer ${Storage().storage['token']}"
      };
      var route = HttpClient().createUri(ServerAddresses.updateProfile);
      var data = <String, dynamic>{
        "user_first_name": firstName,
        "user_middle_name": middleName,
        "user_last_name": lastName,
        "user_identification_country_of_issue": country,
        "user_is_admin": isAdmin,
        "user_identification_number": idNumber,
        "user_email_address": email,
        "user_phone_number": phoneNumber
      };

      var response = await http.patch(route, body: data, headers: headers);
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
        "user_Id": userId.toString(),
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
  Future<ProfileEntity> fetchProfile() async {
    try {
      var headers = HttpClient().createHeader();

      var route = HttpClient().createUri(ServerAddresses.getProfile);

      var response = await http.get(route, headers: headers);
      Map jsonResponse = json.decode(response.body);
      ProfileEntity profile = ProfileEntity.fromJson(jsonDecode(response.body));
      if (jsonResponse['status'] != 200) {
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
