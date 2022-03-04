import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductPressed extends ProductEvent {
  final String? addedBy;
  final String? title;
  final String? body;
  final String? productTypeName;
  final String? status;
  final String? dateLaunched;
  final String? img;
  ProductPressed(
      {this.addedBy,
      this.title,
      this.body,
      this.productTypeName,
      this.status,
      this.dateLaunched,
      this.img});

  @override
  List<Object> get props => [
        addedBy.toString(),
        title.toString(),
        body.toString(),
        productTypeName.toString(),
        status.toString(),
        dateLaunched.toString(),
        img.toString()
      ];
}

class ShowProductPressed extends ProductEvent {
  ShowProductPressed();
}
