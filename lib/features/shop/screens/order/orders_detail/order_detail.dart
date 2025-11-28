import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/customer/all_customer/responsive_screens/customer_desktop_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/customer/all_customer/responsive_screens/customer_mobile_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/customer/all_customer/responsive_screens/customer_tablet_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/order/all_orders/responsive_screens/order_desktop_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/order/all_orders/responsive_screens/order_mobile_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/order/all_orders/responsive_screens/order_tablet_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/order/orders_detail/responsive_screens/order_detail_desktop_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/order/orders_detail/responsive_screens/order_detail_mobile_screen.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/order/orders_detail/responsive_screens/order_detail_tablet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments;
    final orderId= Get.parameters['orderId'];
    return  TSiteTemplate(
      desktop: OrderDetailDesktopScreen(order: order,),
      tablet: OrderDetailTabletScreen(order: order,),
      mobile: OrderDetailMobileScreen(order: order,),
    );
  }
}
