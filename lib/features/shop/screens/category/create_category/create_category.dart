
import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/category/create_category_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/category/create_category/responsive_screens/create_category_desktop.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/category/create_category/responsive_screens/create_category_mobile.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/category/create_category/responsive_screens/create_category_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCategoryScreen extends StatelessWidget{
  const CreateCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateCategoryController());
   return const TSiteTemplate(desktop: CreateCategoryDesktopScreen(),tablet: CreateCategoryTabletScreen(),mobile: CreateCategoryMobileScreen(),);
  }

}