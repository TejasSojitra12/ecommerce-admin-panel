import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/customer/all_customer/responsive_screens/customer_desktop_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/customer/all_customer/responsive_screens/customer_mobile_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/customer/all_customer/responsive_screens/customer_tablet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../controllers/customer/customer_controller.dart';

class CustomerScreen extends StatelessWidget{
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
   return const TSiteTemplate(desktop: CustomerDesktopScreen(),tablet: CustomerTabletScreen(),mobile: CustomerMobileScreen(),);
  }

}