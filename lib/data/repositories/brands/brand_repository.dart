import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/barnd_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/brand_category.dart';
import 'package:e_commerce_admin_pannel/utils/exceptions/firebase_exceptions.dart';
import 'package:e_commerce_admin_pannel/utils/exceptions/format_exceptions.dart';
import 'package:e_commerce_admin_pannel/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all brands from the 'Brands' collection
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      final result = snapshot.docs
          .map(
            (doc) => BrandModel.fromSnapshot(doc),
          )
          .toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on SocketException catch (e) {
      throw SocketException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get all Brand Categories from Brand Category Collection
  Future<List<BrandCategoryModel>> getAllBrandCategories() async {
    try {
      final brandCategoryQuery = await _db.collection('BrandCategory').get();
      final brandCategories = brandCategoryQuery.docs
          .map(
            (doc) => BrandCategoryModel.fromSnapshot(doc),
          )
          .toList();
      return brandCategories;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on SocketException catch (e) {
      throw SocketException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<BrandCategoryModel>> getCategoriesOfSpecificBrand(
      String brandId) async {
    try {
      final brandCategoryQuery = await _db
          .collection('BrandCategory')
          .where('brandId', isEqualTo: brandId)
          .get();
      final brandCategories = brandCategoryQuery.docs
          .map(
            (doc) => BrandCategoryModel.fromSnapshot(doc),
          )
          .toList();
      return brandCategories;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on SocketException catch (e) {
      throw SocketException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> deleteBrand(BrandModel brand) async {
    try {
      await _db.runTransaction((transaction) async {
        final brandRef = _db.collection('Brands').doc(brand.id);
        final brandSnap = await transaction.get(brandRef);

        if (!brandSnap.exists) {
          throw Exception('Brand does not exist');
        }

        final BrandCategoriesSnapsnot = await _db
            .collection('BrandCategory')
            .where('brandId', isEqualTo: brand.id)
            .get();
        final brandCategories = BrandCategoriesSnapsnot.docs
            .map(
              (doc) => BrandCategoryModel.fromSnapshot(doc),
            )
            .toList();

        if (brandCategories.isNotEmpty) {
          for (var brandCategorySnap in brandCategories) {
            transaction.delete(
                _db.collection('BrandCategory').doc(brandCategorySnap.id));
          }
        }

        transaction.delete(brandRef);
      });
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<String> createBrand(BrandModel brand) async {
    try {
      final data = await _db.collection('Brands').add(brand.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<String> createBrandCategory(BrandCategoryModel brand) async {
    try {
      final data = await _db.collection('BrandCategory').add(brand.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateBrand(BrandModel brand) async {
    try {
      await _db.collection('Brands').doc(brand.id).update(brand.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Delete a brand category document in the 'BrandCategory' collection
  Future<void> deleteBrandCategory(String brandCategoryId) async {
    try {
      await _db.collection('BrandCategory').doc(brandCategoryId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
