import 'package:flutter/material.dart';

import '../../../domain/model/product_entity.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen({Key? key, this.productEntity}) : super(key: key);
  final ProductEntity? productEntity;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
