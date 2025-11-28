import 'package:e_commerce_admin_pannel/data/repositories/user/user_repository.dart';
import 'package:e_commerce_admin_pannel/features/authentication/models/user/user_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/address/address_repository.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/models/user_model.dart';

class CustomerDetailController extends GetxController{
  static CustomerDetailController get instance => Get.find();
  
  RxBool orderLoading = true.obs;
  RxBool addressLoading  = true.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<bool> selectedRows = <bool>[].obs;
  Rx<UserModel> customer = UserModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());
  final searchTextController = TextEditingController();
  RxList<OrderModel> allCustomerOrders = <OrderModel>[].obs;
  RxList<OrderModel> filteredCustomerOrders = <OrderModel>[].obs;

/// -- Load Customer order
Future<void> getCustomerOrders()async{
  try{
    orderLoading.value=true;

    if(customer.value.id!=null && customer.value.id!.isNotEmpty){
      customer.value.orders = await UserRepository.instance.fetchUserOrders(customer.value.id!);
    }

    allCustomerOrders.assignAll(customer.value.orders ?? []);

    filteredCustomerOrders.assignAll(customer.value.orders ?? []);

    selectedRows.assignAll(List.generate(customer.value.orders != null ? customer.value.orders!.length : 0, (index) => false));

  }catch(e){
    TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
  }finally {
    orderLoading.value = false;
  }
}

Future<void> getCustomerAddress()async{
  try{
    addressLoading.value=true;

    if(customer.value.id!=null && customer.value.id!.isNotEmpty){
      customer.value.addresses = await addressRepository.fetchUserAddresses(customer.value.id!);
    }
  }catch (e){
    TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());

  }finally {
    addressLoading.value = false;
  }
}

void searchQuery(String query) {
  filteredCustomerOrders.assignAll(
    allCustomerOrders.where((customer) => customer.id.toLowerCase().contains(query.toLowerCase()) || customer.orderDate.toString().contains(query.toLowerCase()),),
  );

  update();
}

void sortById(int columnIndex, bool ascending) {
  this.sortColumnIndex.value = columnIndex;
  sortAscending.value = ascending;
  filteredCustomerOrders.sort(
        (a, b) {
      if (ascending) {
        return a.id.compareTo(b.id);
      } else {
        return b.id.compareTo(a.id);
      }
    },
  );
}
  
}