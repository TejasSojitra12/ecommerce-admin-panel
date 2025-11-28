import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/product_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/product/edit_product/responsive_screen/edit_product_desktop.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/product/edit_product/responsive_screen/edit_product_mobile.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/product/edit_product/responsive_screen/edit_product_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/routes.dart';

class EditProductScreen extends StatelessWidget{
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProductController());
    final product = Get.arguments;
    if (product == null) {
      // redirect safely after first frame
      Future.microtask(() => Get.offAllNamed(TRoutes.dashboard));
      return const SizedBox.shrink();
    }
    controller.initProductData(product);
    return TSiteTemplate(desktop: EditProductDesktopScreen(product: product,),mobile: EditProductMobileScreen(product: product,),);
  }

}