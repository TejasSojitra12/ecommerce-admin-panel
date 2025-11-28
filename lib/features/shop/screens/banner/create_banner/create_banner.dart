import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/banner/create_banner_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/banner/create_banner/responsive_screen/create_banner_desktop.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/banner/create_banner/responsive_screen/create_banner_mobile.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/banner/create_banner/responsive_screen/create_banner_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBannerScreen extends StatelessWidget{
  const CreateBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBannerController());
    return const TSiteTemplate(desktop: CreateBannerDesktopScreen(),tablet: CreateBannerTabletScreen(),mobile: CreateBannerMobileScreen(),);
  }

}