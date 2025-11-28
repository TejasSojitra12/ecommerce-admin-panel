import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/brand/edit_brand_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/barnd_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/brand/edit_brand/responsve_screens/edit_brand_desktop.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/brand/edit_brand/responsve_screens/edit_brand_mobile.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/brand/edit_brand/responsve_screens/edit_brand_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/routes.dart';
class EditBrandScreen extends StatelessWidget{
  const EditBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = Get.arguments;
    if (brand == null) {
      // redirect safely after first frame
      Future.microtask(() => Get.offAllNamed(TRoutes.dashboard));
      return const SizedBox.shrink();
    }
    return TSiteTemplate(
      desktop: EditBrandDesktopScreen(brand: brand,),
      tablet: EditBrandTabletScreen(brand: brand,),
      mobile: EditBrandMobileScreen(brand: brand,),
    );
  }

}