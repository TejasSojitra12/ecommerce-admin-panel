import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/customer/all_customer/responsive_screens/customer_desktop_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/customer/all_customer/responsive_screens/customer_mobile_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/customer/all_customer/responsive_screens/customer_tablet_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/order/all_orders/responsive_screens/order_desktop_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/order/all_orders/responsive_screens/order_mobile_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/order/all_orders/responsive_screens/order_tablet_screen.dart';
import 'package:flutter/material.dart';

import '../../../controllers/order/order_controller.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return const TSiteTemplate(
      desktop: OrderDesktopScreen(),
      tablet: OrderTabletScreen(),
      mobile: OrderMobileScreen(),
    );
  }
}
