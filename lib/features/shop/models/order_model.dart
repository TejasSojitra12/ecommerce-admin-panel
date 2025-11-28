import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'address_model.dart';
import 'cart_item_model.dart';

class OrderModel {
  final String id;
  final String docId;
  final String userId;
   OrderStatus status;
  final double totalAmount;
  final double shippingCost;
  final double taxCost;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? shippingAddress;
  final AddressModel? billingAddress;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;
  final bool billingAddressSameAsShipping;

  OrderModel(
      {required this.id,
      this.userId = '',
      this.docId = '',
      required this.status,
      required this.totalAmount,
      required this.shippingCost,
      required this.taxCost,
      required this.orderDate,
      this.paymentMethod = 'Paypal',
      this.billingAddress,
      this.billingAddressSameAsShipping = true,
      this.shippingAddress,
      this.deliveryDate,
      required this.items});

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Processing';

  static OrderModel empty() => OrderModel(
    id: '',
    status: OrderStatus.pending,
    totalAmount: 0.0,
    shippingCost: 0.0,
    taxCost: 0.0,
    orderDate: DateTime.now(),
    items: [],
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'shippingCost': shippingCost,
      'taxCost': taxCost,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'shippingAddress': shippingAddress?.toJson(),
      'billingAddress': billingAddress?.toJson(),
      'billingAddressSameAsShipping': billingAddressSameAsShipping,
      'items': items.map((x) => x.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return OrderModel(
      docId: snapshot.id,
      id:data.containsKey('id') ?  data['id'] as String : '',
      userId: data.containsKey('userId') ? data['userId'] as String : '',
      status: data.containsKey('status') ? OrderStatus.values.firstWhere(
        (element) => element.toString() == data['status'],
      ) :OrderStatus.pending,
      totalAmount: data.containsKey('totalAmount')? data['totalAmount'] as double : 0.0 ,
      shippingCost: data.containsKey('shippingCost') ? data['shippingCost'] as double : 0.0,
      taxCost: data.containsKey('taxCost') ? data['taxCost'] as double : 0.0,
      orderDate: data.containsKey('orderDate') ? (data['orderDate'] as Timestamp).toDate() : DateTime.now(),
        paymentMethod: data.containsKey('paymentMethod') ? data['paymentMethod'] as String : 'Paypal',
      shippingAddress: data.containsKey('shippingAddress') ? AddressModel.fromMap(data['shippingAddress'] as Map<String, dynamic>) : null,

        billingAddress: data.containsKey('billingAddress') ? AddressModel.fromMap(data['billingAddress'] as Map<String, dynamic>) : null,
      billingAddressSameAsShipping: data.containsKey('billingAddressSameAsShipping') ? data['billingAddressSameAsShipping'] as bool : true,
      deliveryDate: data.containsKey('deliveryDate') ? (data['deliveryDate'] as Timestamp).toDate() : null,
      items: (data.containsKey('items') ? data['items'] as List<dynamic> : []).map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }
}
