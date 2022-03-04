import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimi_na_wewe_sacco/domain/model/product_entity.dart';
import 'package:mimi_na_wewe_sacco/view/feature/product/product.dart';

import '../../../data/repository/product/product_repository.dart';
import '../authentication/authentication.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository? productRepository;
  final AuthenticationBloc? authenticationBloc;

  ProductBloc({
    @required this.productRepository,
    @required this.authenticationBloc,
  })  : assert(productRepository != null),
        assert(authenticationBloc != null),
        super(ProductInitialState()) {
    on<ProductPressed>((event, emit) async {
      emit(ProductProcessingState());
      try {
        await productRepository!.addProduct(
            addedBy: event.addedBy,
            title: event.title,
            body: event.body,
            productTypeName: event.productTypeName,
            dateLaunched: event.dateLaunched,
            status: event.status,
            img: event.img);
        emit(ProductFinishedState());
      } catch (error) {
        emit(ProductErrorState(error.toString()));
      }
    });

    on<ShowProductPressed>((event, emit) async {
      emit(ProductProcessingState());
      try {
        List<ProductEntity>? products =
            await productRepository!.fetchAllProducts();
        emit(ProductLoaded(products: products));
      } catch (error) {
        emit(ProductErrorState(error.toString()));
      }
    });
  }
}
