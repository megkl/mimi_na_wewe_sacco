class ProductModel {
  String? name;
  String? prodDesc;
  String? prodType;
  String prodStatus;

  ProductModel(this.name, this.prodDesc, this.prodType, this.prodStatus);
}

List<ProductModel> products = productData
    .map(
      (Map<String, dynamic> item) => ProductModel(
          item['name'], item['prodDesc'], item['prodStatus'], item['prodType']),
    )
    .toList();

var productData = [
  {
    "name": "Product 2",
    "prodDesc": "Car mortgage loans",
    "prodStatus": "Active",
    "prodType": "Car Mortgage",
  },
  {
    "name": "Product 21",
    "prodDesc": "House mortgage loans",
    "prodStatus": "Active",
    "prodType": "House Mortgage",
  }
];
