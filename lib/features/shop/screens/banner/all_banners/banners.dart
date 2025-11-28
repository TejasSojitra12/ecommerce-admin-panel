import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/banner/banner_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/banner/create_banner_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/banner/all_banners/responsive_screen/banners_desktop.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/banner/all_banners/responsive_screen/banners_mobile.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/banner/all_banners/responsive_screen/banners_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return const TSiteTemplate(
      desktop: BannerDesktopScreen(),
      mobile: BannerMobileScreen(),
      tablet: BannerTabletScreen(),
    );
  }
}
