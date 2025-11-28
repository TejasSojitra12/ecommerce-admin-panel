import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/product_category_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/order_model.dart';


class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get all Order related to current user
  Future<List<OrderModel>> getAllOrders() async {
    try {
      final result = await _db.collection('Orders').orderBy('orderDate',descending: true).get();
      print('Order : ${result.docs.length}');
      return result.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();

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

  /// Store a new user order
Future<void> addOrder(OrderModel order) async {
    try {
    await _db.collection('Orders').add(order.toJson());
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

/// Update order status
Future<void> updateOrderStatus(String orderId, Map<String, dynamic> data) async {
  try {
    await _db.collection('Orders').doc(orderId).update(data);
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

/// Delete order
Future<void> deleteOrder(OrderModel order) async {
    try {
    await _db.collection('Orders').doc(order.id).delete();
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
