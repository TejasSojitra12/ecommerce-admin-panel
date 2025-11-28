
import 'package:e_commerce_admin_pannel/common/widgets/layout/sidebars/sidebar_controller.dart';
import 'package:e_commerce_admin_pannel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoutesObservers extends GetObserver{

  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    final sidebarController = Get.put(SideBarController());

    if(previousRoute!=null){
      for(var routeName in TRoutes.sidebarMenuItems){
        if(previousRoute.settings.name == routeName)
          {
            sidebarController.activeItem.value = routeName;
          }

      }
    }
  }

}