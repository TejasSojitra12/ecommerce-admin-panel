
import 'package:e_commerce_admin_pannel/features/personalization/controllers/settings_controller.dart';
import 'package:e_commerce_admin_pannel/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

import '../features/personalization/controllers/user_controller.dart';

class GeneralBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(()=> NetworkManager(),fenix: true);
   Get.lazyPut(()=> UserController(),fenix: true);
   Get.lazyPut(()=> SettingsController(),fenix: true);
  }

}