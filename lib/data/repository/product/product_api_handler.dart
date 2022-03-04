import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mimi_na_wewe_sacco/domain/model/product_entity.dart';

import '../../../config/server_address.dart';
import '../utils.dart';

class ProductApiHandler {
  @override
  Future<void> addProduct(
      String? addedBy,
      String? title,
      String? body,
      String? productTypeName,
      String? status,
      String? dateLaunched,
      String? img) async {
    try {
      var headers = HttpClient().createHeader();

      var data = <String, dynamic>{
        "addedBy": addedBy,
        "title": title,
        "body": body,
        "product_type_name": productTypeName,
        "status": status,
        "date_launched": dateLaunched,
      };
      var res = json.encode(data);
      var route = HttpClient().createUri(ServerAddresses.addProduct);

      var response = await http.post(route, body: res, headers: headers);
      Map jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] != 200) {
        throw jsonResponse['message'];
      }
      //return jsonResponse['token'];
    } catch (error) {
      rethrow;
    }
  }

  Future<List<ProductEntity>?> fetchAllProducts() async {
    try {
      var headers = HttpClient().createHeader();
      var route = HttpClient().createUri(ServerAddresses.getProductList);

      var response = await http.get(route, headers: headers);
      var jsonResponse = json.decode(response.body);

      if (jsonResponse['status'] != 200) {
        if (jsonResponse['status'] == 401) {
          throw jsonResponse['message'];
        } else if (jsonResponse['status'] == 500) {
          throw "No internet connection";
        }
      }
      List<ProductEntity>? products =
          ProductList.fromJson(jsonResponse).data!.toList();

      return products;
    } catch (error) {
      rethrow;
    }
  }

  Future<ProductEntity> updateProduct(
      String? addedBy,
      String? title,
      String? body,
      String? productTypeName,
      String? status,
      String? dateLaunched,
      String? img) async {
    try {
      var headers = HttpClient().createHeader();

      var data = <String, dynamic>{
        "addedBy": addedBy,
        "title": title,
        "body": body,
        "product_type_name": productTypeName,
        "status": status,
        "date_launched": dateLaunched,
      };
      var res = json.encode(data);
      var route = HttpClient().createUri(ServerAddresses.updateProduct);

      var response = await http.post(route, body: res, headers: headers);
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] != 200) {
        throw jsonResponse['message'];
      }
      return jsonResponse;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteProductAccount(String? id) async {
    try {
      var headers = HttpClient().createHeader();

      var route =
          HttpClient().createUri(ServerAddresses.deleteProduct + id.toString());

      var response = await http.post(route, headers: headers);
      Map jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] != 200) {
        throw jsonResponse['message'];
      }
      //return jsonResponse['token'];
    } catch (error) {
      rethrow;
    }
  }

  // Future<ProductEntity> getProductById(String? id) async {
  //   try {
  //     var headers = HttpClient().createHeader();

  //     var route = HttpClient()
  //         .createUri(ServerAddresses.getProductById + id.toString());

  //     var response = await http.post(route, headers: headers);
  //     var jsonResponse = json.decode(response.body);
  //     if (jsonResponse['status'] != 200) {
  //       throw jsonResponse['message'];
  //     }
  //     return jsonResponse;
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

}
