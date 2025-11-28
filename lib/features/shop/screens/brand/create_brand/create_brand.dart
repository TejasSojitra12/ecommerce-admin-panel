import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/brand/create_brand/responsive_screens/create_brand_desktop.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/brand/create_brand/responsive_screens/create_brand_mobile.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/brand/create_brand/responsive_screens/create_brand_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/brand/create_brand_controller.dart';
class CreateBrandScreen extends StatelessWidget{
  const CreateBrandScreen({super.key});

  @override
  Widget build(BuildContext context){
    final controller = Get.put(CreateBrandController());

    return const TSiteTemplate(
      desktop: CreateBrandDesktopScreen(),
      tablet: CreateBrandTabletScreen(),
      mobile: CreateBrandMobileScreen(),
    );
  }
}