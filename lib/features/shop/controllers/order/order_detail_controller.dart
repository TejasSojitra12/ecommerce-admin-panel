import 'package:e_commerce_admin_pannel/data/repositories/user/user_repository.dart';
import 'package:e_commerce_admin_pannel/features/authentication/models/user/user_model.dart';
import 'package:get/get.dart';

import '../../../../utils/popups/loaders.dart';
import '../../../personalization/models/user_model.dart';
import '../../models/order_model.dart';

class OrderDetailController extends GetxController{
  static OrderDetailController get instance => Get.find();

  RxBool loading = false.obs;
  Rx<OrderModel> order = OrderModel.empty().obs;
  Rx<UserModel> customer = UserModel.empty().obs;

  /// -- Load customer orders
Future<void> getCustomerOfCurrentOrder()async{
  try{
    loading.value =true;
    final user = await UserRepository.instance.fetchUserDetails(order.value.userId);
    customer.value = user;
  }catch(e){
    TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
  }finally{
    loading.value=false;
  }
}

}