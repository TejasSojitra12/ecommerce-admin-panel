import 'package:e_commerce_admin_pannel/data/abstract/base_data_table_controller.dart';
import 'package:e_commerce_admin_pannel/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/order/order_repository.dart';
import '../../../../utils/constants/enums.dart';
import '../../models/order_model.dart';

class OrderController extends TBaseController<OrderModel>{
  static OrderController get instance => Get.find();

  RxBool statusLoader = false.obs;
  var orderStatus = OrderStatus.delivered.obs;
  final _orderRepository = Get.put(OrderRepository());



  @override
  bool containSearchQuery(item, String query) {
    return item.id.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(item) async{
    await _orderRepository.deleteOrder(item);
  }

  @override
  Future<List<OrderModel>> fetchItems() async{
   statusLoader.value = true;
   return await _orderRepository.getAllOrders();
  }
  
  void sortById(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (OrderModel o) => o.totalAmount.toString().toLowerCase(),);
  }

  void sortByDate(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (OrderModel o) => o.orderDate.toString().toLowerCase(),);
  }

  /// Update order status
  Future<void> updateOrderStatus(OrderModel order, OrderStatus newStatus) async {
    try {
      statusLoader.value = true;
      order.status = newStatus;
      await _orderRepository.updateOrderStatus(order.docId,{'status': newStatus.toString()});
      updateItemFromList(order);
      orderStatus.value=newStatus;
      statusLoader.value = false;
      TLoaders.successSnackBar(title: 'Updated',message: 'Order status updated');
    } catch (e) {
    TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
    }finally{
      statusLoader.value = false;
    }
  }

}