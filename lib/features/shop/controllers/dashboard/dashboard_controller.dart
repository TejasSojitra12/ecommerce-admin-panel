import 'package:e_commerce_admin_pannel/data/abstract/base_data_table_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/order/order_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/order_model.dart';
import 'package:e_commerce_admin_pannel/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/enums.dart';
import '../customer/customer_controller.dart';

class DashboardController extends TBaseController<OrderModel> {
  static DashboardController get instance => Get.find();

  final orderController = Get.put(OrderController());
  final customerController = Get.put(CustomerController());

  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus,int> orderStatusData = <OrderStatus,int>{}.obs;
  final RxMap<OrderStatus,double> totalAmounts = <OrderStatus,double>{}.obs;

  /// -- Order
  // static final List<OrderModel> orders=[];


  void _calculateWeeklySales() {
    // Reset Weekly to Zero
    weeklySales.value = List<double>.filled(7, 0.0);

    for (var order in orderController.allItems) {
      final orderWeekStart = THelperFunctions.getStartOfWeek(order.orderDate);

      // Check if the order is within the current week
      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(const Duration(days: 7)).isAfter(DateTime.now())) {
        int index = (order.orderDate.weekday - 1) % 7;

        // Ensure the index is not negative
        index = index < 0 ? index + 7 : index;

        weeklySales[index] += order.totalAmount;
      }
    }

    print('Weekly Sales: $weeklySales');
  }

  void _calculateOrderStatusData() {
    // Reset status Data
    orderStatusData.clear();

    // Map to store total amount for each status
    totalAmounts.value = {for(var status in OrderStatus.values) status : 0.0 };

    for(var order in orderController.allItems){

      // count orders
      final status = order.status;
      orderStatusData[status] = (orderStatusData[status]??0)+1;

      // Calculate amount for each order
      totalAmounts[status] = (totalAmounts[status] ?? 0) + order.totalAmount;

    }

  }

  String getDisplayStatusName(OrderStatus status){
    switch(status){
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shopped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
      }
  }

  @override
  bool containSearchQuery(OrderModel item, String query) {
  return false;
  }

  @override
  Future<void> deleteItem(OrderModel item) async{
  }

  @override
  Future<List<OrderModel>> fetchItems() async {
    if(orderController.allItems.isEmpty){
      await orderController.filteredItems();
    }

    if(customerController.allItems.isEmpty){
      await customerController.fetchItems();
    }

    _calculateWeeklySales();
    _calculateOrderStatusData();

    return orderController.allItems;
  }
}