import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/category/edit_category_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/category_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/category/edit_category/responsive_screens/edit_category_desktop.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/category/edit_category/responsive_screens/edit_category_mobile.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/category/edit_category/responsive_screens/edit_category_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/routes.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditCategoryController());
    final category = Get.arguments;
    if (category == null) {
      // redirect safely after first frame
      Future.microtask(() => Get.offAllNamed(TRoutes.dashboard));
      return const SizedBox.shrink();
    }
    controller.init(category);
    return TSiteTemplate(
      desktop: EditCategoryDesktopScreen(
        category: category,
      ),
      tablet: EditCategoryTabletScreen(
        category: category,
      ),
      mobile: EditCategoryMobileScreen(
        category: category,
      ),
    );
  }
}
