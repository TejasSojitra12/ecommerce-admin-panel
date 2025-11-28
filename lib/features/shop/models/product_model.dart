import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin_pannel/utils/formatters/formatter.dart';

import 'barnd_model.dart';
import 'product_attribute_model.dart';
import 'product_variationModel.dart';

class ProductModel {
  String id;
  int stock;
  int soldQuantity;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? discription;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;
  ProductModel({
    required this.id,
    required this.stock,
    required this.price,
    required this.title,
    required this.thumbnail,
    required this.productType,
    this.sku,
    this.date,
    this.isFeatured,
    this.salePrice = 0.0,
    this.soldQuantity = 0,
    this.brand,
    this.discription,
    this.categoryId,
    this.images,
    this.productAttributes,
    this.productVariations,
  });

  String get formattedDate => TFormatter.formatDate(date);

  // empty helper function
  static ProductModel empty() => ProductModel(
      id: '', stock: 0, price: 0, title: '', thumbnail: '', productType: '');

  toJson() {
    return {
      'Id': id,
      'Stock': stock,
      'SKU': sku,
      'Price': price,
      'Title': title,
      'SalePrice': salePrice,
      'Thumbnail': thumbnail,
      'IsFeatured': isFeatured,
      'Brand': brand!.toJson(),
      'Discription': discription,
      'CategoryId': categoryId,
      'Images': images ?? [],
      'ProductType': productType,
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((x) => x.toJson()).toList()
          : [],
      'ProductVariations': productVariations != null
          ? productVariations!.map((x) => x.toJson()).toList()
          : [],
    };
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) {
      return ProductModel.empty();
    }
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      sku: data['SKU'],
      title: data['Title'],
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      discription: data['Discription'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: BrandModel.fromMap(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'] as List<dynamic>)
          .map(
            (e) => ProductAttributeModel.fromJson(e),
          )
          .toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>)
          .map(
            (e) => ProductVariationModel.fromJson(e),
          )
          .toList(),
    );
  }

  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      sku: data['SKU'],
      title: data['Title'],
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      discription: data['Discription'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: BrandModel.fromMap(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'] as List<dynamic>)
          .map(
            (e) => ProductAttributeModel.fromJson(e),
          )
          .toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>)
          .map(
            (e) => ProductVariationModel.fromJson(e),
          )
          .toList(),
    );
  }
}
