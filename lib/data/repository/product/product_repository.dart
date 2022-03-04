import 'package:mimi_na_wewe_sacco/domain/model/product_entity.dart';

abstract class ProductRepository {
  Future<void> addProduct(
      {String? addedBy,
      String? title,
      String? body,
      String? productTypeName,
      String? status,
      String? dateLaunched,
      String? img});

  Future<List<ProductEntity>?> fetchAllProducts();

  Future<void> updateProductBillingInfo(
      {String? addedBy,
      String? title,
      String? body,
      String? productTypeName,
      String? status,
      String? dateLaunched,
      String? img});

  Future<void> deleteProductAccount({String? id});

  Future<ProductEntity> fetchProductById();
}
