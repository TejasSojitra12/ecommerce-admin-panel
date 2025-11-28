import 'package:e_commerce_admin_pannel/routes/routes.dart';
import 'package:e_commerce_admin_pannel/utils/device/device_utility.dart';
import 'package:get/get.dart';

class SideBarController extends GetxController {
  final activeItem = TRoutes.dashboard.obs;
  final hoverItem = ''.obs;

  @override
  void onInit() {
    activeItem.value = Get.currentRoute;

    super.onInit();
  }

  void changeActiveItem(String route) => activeItem.value = route;

  void changeHoverItem(String route) {
    if (!isActive(route)) {
      hoverItem.value = route;
    }
  }

  bool isActive(String route) => activeItem.value == route;

  bool isHovering(String route) => hoverItem.value == route;

  void menuOnTap(String route) {
    if (!isActive(route)) {
      changeActiveItem(route);
      if (TDeviceUtils.isMobileScreen(Get.context!)) Get.back();
      Get.toNamed(route);
    }
  }
}
