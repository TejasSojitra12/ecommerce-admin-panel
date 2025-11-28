
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin_pannel/utils/formatters/formatter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';




class ImageModel {
  String id;
  final String url;
  final String folder;
  final int? sizeBytes;
  String mediaCategory;
  final String filename;
  final String? fullPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contentType;

  // Not Mapped
  final dynamic file;
  RxBool isSelected = false.obs;
  final Uint8List? localImageToDisplay;

  ImageModel(
      {this.id = '',
      required this.url,
      required this.folder,
      this.sizeBytes,
      required this.filename,
      this.fullPath,
      this.createdAt,
      this.updatedAt,
      this.contentType,
      this.file,
      this.localImageToDisplay,
      this.mediaCategory = ''});

  /// Static functions to create an empty model
  static ImageModel empty() => ImageModel(url: '', folder: '', filename: '');

  String get createdAtFormatted => TFormatter.formatDate(createdAt);

  String get updatedAtFormatted => TFormatter.formatDate(updatedAt);

  /// Convert to JSON to Store in Database
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'folder': folder,
      'sizeBytes': sizeBytes,
      'filename': filename,
      'fullPath': fullPath,
      'createdAt': createdAt?.toUtc(),
      'contentType': contentType,
      'mediaCategory': mediaCategory,
    };
  }

  factory ImageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return ImageModel(
        id: document.id,
        url: data['url'] ?? '',
        folder: data['folder'] ?? '',
        sizeBytes: data['sizeBytes']??0,
        filename: data['filename']??'',
        fullPath: data['fullPath']??'',
        createdAt: data.containsKey('createdAt') ? data['createdAt']?.toDate() : null,
        updatedAt: data.containsKey('updatedAt') ? data['updatedAt']?.toDate() : null,
        contentType: data['contentType'] ?? '',
        mediaCategory: data['mediaCategory'],
      );
    }else{
      return ImageModel.empty();
    }
  }

  /// Map Firebase Storage Data
  factory ImageModel.fromFirebaseMetadata(FullMetadata metaData,String folder,String filename,String downloadUrl){
    return ImageModel(
      url: downloadUrl,
      folder: folder,
      filename: filename,
      sizeBytes: metaData.size,
      updatedAt: metaData.updated,
      fullPath: metaData.fullPath,
      createdAt: metaData.timeCreated,
      contentType: metaData.contentType,
    );
  }
}
