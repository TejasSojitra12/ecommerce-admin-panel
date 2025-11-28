import 'package:cloud_firestore/cloud_firestore.dart';

class SettingModel {
  final String? id;
  double taxRate;
  double shippingCost;
  double? freeShippingThreshold;
  String appName;
  String appLogo;

  SettingModel({
    this.id,
    this.taxRate = 0.0,
    this.shippingCost = 0.0,
    this.freeShippingThreshold,
    this.appName = '',
    this.appLogo = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taxRate': taxRate,
      'shippingCost': shippingCost,
      'freeShippingThreshold': freeShippingThreshold,
      'appName': appName,
      'appLogo': appLogo,
    };
  }

  factory SettingModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return SettingModel(
        id: document.id,
        taxRate: (data['taxRate'] as num?)?.toDouble() ?? 0.0,
        shippingCost: (data['shippingCost'] as num?)?.toDouble() ?? 0.0,
        freeShippingThreshold: (data['freeShippingThreshold'] as num?)?.toDouble(),
        appName: data.containsKey('appName') ? data['appName'] ?? '' : '',
        appLogo: data.containsKey('appLogo') ? data['appLogo'] ?? '' : '',
      );
    }else{
      return SettingModel();
    }
  }
}
