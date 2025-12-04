import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/dashboard/responsive_screens/dashboard_desktop.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/dashboard/responsive_screens/dashboard_mobile.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/dashboard/responsive_screens/dashboard_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget{
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    return const TSiteTemplate(desktop: DashboardDesktopScreen(),
      tablet: DashboardTabletScreen(),
      mobile: DashboardMobileScreen(),);
  }

}