import 'package:e_commerce_admin_pannel/data/abstract/base_data_table_controller.dart';
import 'package:e_commerce_admin_pannel/data/repositories/user/user_repository.dart';
import 'package:e_commerce_admin_pannel/features/authentication/models/user/user_model.dart';
import 'package:get/get.dart';

import '../../../personalization/models/user_model.dart';

class CustomerController extends TBaseController<UserModel>{
  static CustomerController get instance => Get.find();

  final _customerRepository = Get.put(UserRepository());
  @override
  bool containSearchQuery(UserModel item, String query) {
    return item.fullName.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(UserModel item) async{
    return await _customerRepository.deleteUser(item.id!);
  }

  @override
  Future<List<UserModel>> fetchItems() async{
   return await _customerRepository.getAllUsers();

  }

  void sortByName(int sortColumnIndex,bool ascending){
    sortByProperty(sortColumnIndex, ascending, (UserModel o) => o.fullName.toString().toLowerCase(),);
  }

}