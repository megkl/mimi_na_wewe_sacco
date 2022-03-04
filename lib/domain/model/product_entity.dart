class ProductEntity {
  String? addedBy;
  String? title;
  String? body;
  String? productTypeName;
  String? status;
  String? dateLaunched;
  String? img;

  ProductEntity(
      {addedBy, title, body, productTypeName, status, dateLaunched, img});

  ProductEntity.fromJson(Map<String, dynamic> json) {
    addedBy = json['addedBy'];
    title = json['title'];
    body = json['body'];
    productTypeName = json['product_type_name'];
    status = json['status'];
    dateLaunched = json['date_launched'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['addedBy'] = addedBy;
    data['title'] = title;
    data['body'] = body;
    data['product_type_name'] = productTypeName;
    data['status'] = status;
    data['date_launched'] = dateLaunched;
    data['img'] = img;
    return data;
  }
}

class ProductList {
  List<ProductEntity>? data;

  ProductList({this.data});

  ProductList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(ProductEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? addedBy;
  String? title;
  String? body;
  String? coverImage;
  String? dateLaunched;
  String? status;
  String? productTypeName;
  int? iV;

  Data(
      {this.sId,
      this.addedBy,
      this.title,
      this.body,
      this.coverImage,
      this.dateLaunched,
      this.status,
      this.productTypeName,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    addedBy = json['addedBy'];
    title = json['title'];
    body = json['body'];
    coverImage = json['coverImage'];
    dateLaunched = json['date_launched'];
    status = json['status'];
    productTypeName = json['product_type_name'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['addedBy'] = this.addedBy;
    data['title'] = this.title;
    data['body'] = this.body;
    data['coverImage'] = this.coverImage;
    data['date_launched'] = this.dateLaunched;
    data['status'] = this.status;
    data['product_type_name'] = this.productTypeName;
    data['__v'] = this.iV;
    return data;
  }
}
