import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin_pannel/features/media/models/image_model.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  // Firebase Storage instance
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload any Image using File
  Future<ImageModel> uploadImageFileInStorage(
      {required Uint8List file,
      required String path,
      required String imageName}) async {
    try {
      // Reference to the storage location
      final Reference reference = _storage.ref('$path/$imageName');
      // Set metadata including the MIME type
      String mimeType = 'image/jpeg'; // Default MIME type
      if (imageName.endsWith('.png')) {
        mimeType = 'image/png';
      }
      final SettableMetadata metadata = SettableMetadata(
        contentType: mimeType,
      );
      // upload file
      await reference.putData(file, metadata);
      // Get Download URL
      final String downloadURL = await reference.getDownloadURL();
      // Fetch metadata
      final FullMetadata fullMetadata = await reference.getMetadata();

      return ImageModel.fromFirebaseMetadata(
          fullMetadata, path, imageName, downloadURL);
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  /// Upload Image data in FireStore
  Future<String> uploadImageFileInDatabase(ImageModel image) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection("Images")
          .add(image.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  // Fetch images from Firestore based on media category and load count
  Future<List<ImageModel>> fetchImagesFromDatabase(
      MediaCategory mediaCategory, int loadCount) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Images")
          .where("mediaCategory", isEqualTo: mediaCategory.name.toString())
          .orderBy("createdAt", descending: true)
          .limit(loadCount)
          .get();
      return querySnapshot.docs
          .map(
            (e) => ImageModel.fromSnapshot(e),
          )
          .toList();
    } on FirebaseException catch (e) {
      print(e.toString());
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  // Load images from Firestore based on media category and load count, and last fetched date

  Future<List<ImageModel>> loadMoreImagesFromDatabase(
      MediaCategory mediaCategory,
      int loadCount,
      DateTime lastFetchedDate) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Images")
          .where("mediaCategory", isEqualTo: mediaCategory.name.toString())
          .orderBy("createdAt",descending: true)
          .startAfter([lastFetchedDate])
          .limit(loadCount)
          .get();
      return querySnapshot.docs
          .map(
            (e) => ImageModel.fromSnapshot(e),
          )
          .toList();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  // Delete file from Firebase Storage and corresponding document from Firestore
Future<void> deleteFileFromStorage(ImageModel image)async{
  try {
   await FirebaseStorage.instance.ref(image.fullPath).delete();
   await FirebaseFirestore.instance.collection('Images').doc(image.id).delete();
  } on FirebaseException catch (e) {
    throw e.message!;
  } on SocketException catch (e) {
    throw e.message;
  } on PlatformException catch (e) {
    throw e.message!;
  } catch (e) {
    throw e.toString();
  }
}
}
