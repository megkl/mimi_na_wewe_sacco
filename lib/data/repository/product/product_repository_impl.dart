import 'package:mimi_na_wewe_sacco/data/repository/product/product_repository.dart';
import 'package:mimi_na_wewe_sacco/domain/model/product_entity.dart';

import 'product_api_handler.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductApiHandler? productApiHandler;

  ProductRepositoryImpl({this.productApiHandler});

  @override
  Future<void> addProduct(
      {String? addedBy,
      String? title,
      String? body,
      String? productTypeName,
      String? status,
      String? dateLaunched,
      String? img}) {
    return productApiHandler!.addProduct(
        addedBy, title, body, productTypeName, status, dateLaunched, img);
  }

  @override
  Future<void> deleteProductAccount({String? id}) {
    return productApiHandler!.deleteProductAccount(id);
  }

  @override
  Future<List<ProductEntity>?> fetchAllProducts() {
    return productApiHandler!.fetchAllProducts();
  }

  @override
  Future<ProductEntity> fetchProductById() {
    // TODO: implement fetchProductById
    throw UnimplementedError();
  }

  @override
  Future<void> updateProductBillingInfo(
      {String? addedBy,
      String? title,
      String? body,
      String? productTypeName,
      String? status,
      String? dateLaunched,
      String? img}) {
    return productApiHandler!.updateProduct(
        addedBy, title, body, productTypeName, status, dateLaunched, img);
  }
}
