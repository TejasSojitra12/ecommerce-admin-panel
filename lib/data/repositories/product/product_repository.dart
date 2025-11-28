import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/product_category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/product_model.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  /// Firebase FireStore instance
  final _db = FirebaseFirestore.instance;

  /* ----------------------------- FUNCTION ----------------------- */

  /// Get all products from FireStore
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection('Products').get();
      final result =
          snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get all product categories from FireStore
  Future<List<ProductCategoryModel>> getProductCategories(
      String productId) async {
    try {
      final snapshot = await _db
          .collection('ProductCategory')
          .where('productId', isEqualTo: productId)
          .get();
      final result = snapshot.docs
          .map((doc) => ProductCategoryModel.fromSnapshot(doc))
          .toList();
      return result;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Create product
  Future<String> createProduct(ProductModel product) async {
    try {
      print("🔍 Checking for Rx types before Firestore…");
      findRxValues(product.toJson());  // <---- ADD THIS

      print("📤 Uploading product to Firestore…");
      print(product.toJson());
      final data = await _db.collection('Products').add(product.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Create Product Category
  Future<String> createProductCategory(
      ProductCategoryModel productCategory) async {
    try {
      final data =
          await _db.collection('ProductCategory').add(productCategory.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Update product
  Future<void> updateProduct(ProductModel product) async {
    try {
      await _db.collection('Products').doc(product.id).update(product.toJson());
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Update product Specific Attribute
  Future<void> updateProductAttribute(
      String id, Map<String, dynamic> data) async {
    try {
      await _db.collection('Products').doc(id).update(data);
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Delete product
  Future<void> deleteProduct(ProductModel product) async {
    try {
      await _db.runTransaction(
        (transaction) async {
          final productRef = _db.collection('Products').doc(product.id);
          final productSnapshot = await transaction.get(productRef);

          if (!productSnapshot.exists) {
            throw Exception('Product does not exist');
          }

          final productCategorySnapshot = await _db
              .collection('ProductCategory')
              .where('ProductId', isEqualTo: product.id)
              .get();
          final productCategories = productCategorySnapshot.docs
              .map((doc) => ProductCategoryModel.fromSnapshot(doc))
              .toList();

          if (productCategories.isNotEmpty) {
            for (var category in productCategories) {
              transaction.delete(
                  _db.collection('ProductCategory').doc(category.categoryId));
            }
          }

          transaction.delete(productRef);
        },
      );
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // remove product category
  Future<void> removeProductCategory(
      String productId, String categoryId) async {
    try {
      final result = await _db
          .collection('ProductCategory')
          .where('ProductId', isEqualTo: productId)
          .where('CategoryId', isEqualTo: categoryId).get();

      for(var doc in result.docs) {
        await doc.reference.delete();
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Recursively scans a map and prints any Rx values found inside.
  void findRxValues(dynamic data, [String path = 'root']) {
    if (data == null) return;

    // If item is Rx type → log it
    if (data is Rx) {
      print('❌ RxType FOUND at $path → ${data.runtimeType}');
      return;
    }

    // If item is a model object → try converting to JSON
    if (data is! Map && data is! List && data is! String && data is! num && data is! bool) {
      try {
        final json = (data as dynamic).toJson();
        findRxValues(json, path);
        return;
      } catch (_) {
        // Not json-convertible
      }
    }

    // If Map → scan entries
    if (data is Map) {
      data.forEach((key, value) {
        findRxValues(value, '$path.$key');
      });
    }

    // If List → scan items
    if (data is List) {
      for (var i = 0; i < data.length; i++) {
        findRxValues(data[i], '$path[$i]');
      }
    }
  }

}
