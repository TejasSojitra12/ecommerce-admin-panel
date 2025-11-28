import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/data/repositories/product/product_repository.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/product_attribute_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/product/create_product/responsive_screen/create_product_desktop.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/product/create_product/responsive_screen/create_product_mobile.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/product/create_product/responsive_screen/create_product_tablet.dart';
import 'package:flutter/material.dart';

import '../../../controllers/product/create_product_controller.dart';
import 'package:get/get.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if(!Get.isRegistered<ProductRepository>()){
      Get.put(ProductRepository());
    }
    /// REGISTER FIRST — VERY IMPORTANT
    if (!Get.isRegistered<ProductVariationController>()) {
      Get.put(ProductVariationController());
    }
    if (!Get.isRegistered<ProductAttributeController>()) {
      Get.put(ProductAttributeController());
    }

    /// NOW create CreateProductController (AFTER dependencies)
    final controller = Get.put(CreateProductController());

    /// NOW safe to call reset
    controller.resetFormValues();

    return const TSiteTemplate(
      desktop: CreateProductDesktopScreen(),
      mobile: CreateProductMobileScreen(),
    );
  }
}
