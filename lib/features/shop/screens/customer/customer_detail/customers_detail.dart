import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/customer/all_customer/responsive_screens/customer_desktop_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/customer/all_customer/responsive_screens/customer_mobile_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/customer/all_customer/responsive_screens/customer_tablet_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/customer/customer_detail/responsive_screens/customer_detail_desktop_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/customer/customer_detail/responsive_screens/customer_detail_mobile_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/customer/customer_detail/responsive_screens/customer_detail_tablet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/customer/customer_detail_controller.dart';

class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerDetailController());
    final customer = Get.arguments;
    return  TSiteTemplate(
      desktop: CustomerDetailDesktopScreen(customer: customer,),
      // tablet: CustomerDetailTabletScreen(customer: customer),
      mobile: CustomerDetailMobileScreen(customer: customer,),
    );
  }
}
