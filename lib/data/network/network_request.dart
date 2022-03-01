import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:mimi_na_wewe_sacco/config/server_address.dart';
import 'package:mimi_na_wewe_sacco/data/error/exceptions.dart';

class NetworkRequest {
  static const STATUS_OK = 200;
  static const STATUS_CREATED = 201;
  static const STATUS_FORBIDDEN = 403;
  static const STATUS_NOTFOUND = 401;
  static const STATUS_SERVICEFAILED = 503;
  static const STATUS_SERVERERROR = 500;

  final Map<String, String> _jsonHeaders = {'content-type': 'application/json'};

  final http.Client? client;
  final RequestType? type;
  final Uri? address;
  final Map<String, dynamic>? body;
  Map<String, String>? headers;
  final List<int>? listBody;
  final String? plainBody;

  NetworkRequest(this.type, this.address,
      {this.client, this.body, this.plainBody, this.listBody, this.headers});

  Future<http.Response> getResult() async {
    //print('ADDRESS: $address');
    if (listBody != null) {
      //print('listBody: ${jsonEncode(listBody)}');
    }
    if (plainBody != null) {
      //print('plainBody: $plainBody');
    }
    if (body != null) {
      //print('body: ${jsonEncode(body)}');
    }
    http.Response response;
    headers ??= _jsonHeaders;
    try {
      Uri? uri = address; //Uri.parse(address);
      switch (type!) {
        case RequestType.post:
          response = await client!.post(
            uri!,
            headers: headers,
            body: jsonEncode(body) ?? plainBody ?? listBody,
          );
          break;
        case RequestType.get:
          response = await client!.get(uri!, headers: headers);
          break;
        case RequestType.put:
          response = await client!
              .put(uri!, body: body ?? plainBody ?? listBody, headers: headers);
          break;
        case RequestType.delete:
          response = await client!.delete(uri!, headers: headers);
          break;
      }
      //print('RESULT: ${response.body}');
      if (response.statusCode != STATUS_OK) {
        throw HttpRequestException();
      }
      return response;
    } catch (exception) {
      if (exception is HttpRequestException) {
        rethrow;
      } else {
        throw RemoteServerException();
      }
    }
  }

  factory NetworkRequest.cardList(
      http.Client client, int pageIndex, int pageSize, int categoryId) {
    List<String> parameters = [];
    if (pageIndex != null) {
      parameters.add('page=${pageIndex + 1}');
    }
    if (pageSize != null) {
      parameters.add('per_page=$pageSize');
    }
    if (categoryId != null) {
      parameters.add('category=$categoryId');
    }
    // if (sortRules != null) {
    //   parameters.add('orderby=${sortRules.jsonRuleName}');
    //   parameters.add('order=${sortRules.jsonOrder}');
    // }
    //TODO add filter rules here
    Uri serverAddress =
        Uri(path: ServerAddresses.serverAddress + '?' + parameters.join('&'));
    return NetworkRequest(
      RequestType.get,
      serverAddress,
      client: client,
    );
  }
}

enum RequestType {
  post,
  get,
  put,
  delete,
}
