
import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/product_image_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/product/all_products/responsive_screen/product_desktop.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/product/all_products/responsive_screen/product_mobile.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/product/all_products/responsive_screen/product_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget{
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
 return TSiteTemplate(desktop: ProductDesktopScreen(),tablet: ProductTabletScreen(),mobile: ProductMobileScreen(),);
  }

}