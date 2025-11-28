import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/personalization/models/setting_model.dart';

class SettingsRepository extends GetxController {
  static SettingsRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> registerSettings(SettingModel setting) async {
    try {
      await _db
          .collection('Settings')
          .doc('GLOBAL_SETTINGS')
          .set(setting.toJson());
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

  /// Function for fetch settings
  Future<SettingModel> fetchSettings() async {
    try {
      final snapshot =
          await _db.collection('Settings').doc('GLOBAL_SETTINGS').get();
      final result = SettingModel.fromSnapshot(snapshot);
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

  /// Function for update
  Future<void> updateSettings(SettingModel setting) async {
    try {
      await _db
          .collection('Settings')
          .doc('GLOBAL_SETTINGS')
          .update(setting.toJson());
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

  /// update single field
  Future<void> updateSettingField(Map<String, dynamic> data) async {
    try {
      await _db.collection('Settings').doc('GLOBAL_SETTINGS').update(data);
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
