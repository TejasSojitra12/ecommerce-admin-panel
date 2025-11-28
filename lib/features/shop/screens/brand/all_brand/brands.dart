import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/brand/brand_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/brand/all_brand/responsive_screens/brands_desktop.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/brand/all_brand/responsive_screens/brands_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandScreen extends StatelessWidget{
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context){
    final controller = Get.put(BrandController());
    return const TSiteTemplate(
      desktop: BrandsDesktopScreen(),
      tablet: BrandsTabletScreen(),
      mobile: BrandsTabletScreen(),
    );
  }
}