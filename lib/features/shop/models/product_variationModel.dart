import 'package:get/get.dart';

class ProductVariationModel {
  final String id;
  String sku;
  Rx<String> image;
  String? description;
  double price;
  double salePrice;
  int stock;
  int soldQuantity;
  Map<String, String> attributeValue;
  ProductVariationModel({
    required this.id,
    this.description = '',
    this.sku = '',
    String image = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    this.soldQuantity =0,
    required this.attributeValue,
  }): image= image.obs;

  // create empty function
  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValue: {});

  toJson() {
    return {
      'Id': id,
      'SKU': sku,
      'Image': image.value,
      'Description': description,
      'Price': price,
      'SalePrice': salePrice,
      'Stock': stock,
      'AttributeValue': attributeValue,
    };
  }

  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
        id: data['Id'] ?? '',
        price: double.parse((data['Price'] ?? 0.0).toString()),
        sku: data['SKU'] ?? '',
        image: data['Image'] ?? '',
        salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
        stock: data['Stock'] ?? 0,
        attributeValue: Map<String, String>.from(
          (data['AttributeValue']),
        ));
  }
}
