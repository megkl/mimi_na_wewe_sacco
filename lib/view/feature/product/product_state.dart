import 'package:equatable/equatable.dart';
import 'package:mimi_na_wewe_sacco/domain/model/product_entity.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductProcessingState extends ProductState {}

class ProductErrorState extends ProductState {
  final String error;

  ProductErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class ProductLoaded extends ProductState {
  List<ProductEntity>? products;
  ProductEntity? product;

  ProductLoaded({this.products});

  @override
  // TODO: implement props
  List<Object> get props => [products!];
}

class ProductUpdated extends ProductState {
  ProductEntity? productEntity;

  ProductUpdated({this.productEntity});

  @override
  // TODO: implement props
  List<Object> get props => [productEntity!];
}

class ProductDeleted extends ProductState {
  String? id;

  ProductDeleted({this.id});

  @override
  // TODO: implement props
  List<Object> get props => [id!];
}

class ProductFinishedState extends ProductState {}
