import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/banner_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  // Firebase FireStore instance
  final _db = FirebaseFirestore.instance;

  // Get all banners from FireStore
  Future<List<BannerModel>> getAllBanner() async {
    try {
      final snapshot = await _db.collection('Banners').get();
      final result =
          snapshot.docs.map((doc) => BannerModel.fromSnapshot(doc)).toList();
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

  // Create a new banner in FireStore
  Future<String> createBanner(BannerModel banner) async {
    try {
      final data = await _db.collection('Banners').add(banner.toJson());
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

  // Update a banner in FireStore
Future<void> updateBanner(BannerModel banner) async {
  try {
    await _db.collection('Banners').doc(banner.id).update(banner.toJson());
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

// Delete a banner from FireStore
Future<void> deleteBanner(String id) async {
  try {
    await _db.collection('Banners').doc(id).delete();
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
}
