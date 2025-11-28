import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/banner/edit_banner_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/banner_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/banner/edit_banner/responsive_screen/edit_banner_desktop.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/banner/edit_banner/responsive_screen/edit_banner_mobile.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/banner/edit_banner/responsive_screen/edit_banner_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/routes.dart';

class EditBannerScreen extends StatelessWidget {
  const EditBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
     Get.put(EditBannerController());
    final banner =
        Get.arguments;
    if (banner == null) {
      // redirect safely after first frame
      Future.microtask(() => Get.offAllNamed(TRoutes.dashboard));
      return const SizedBox.shrink();
    }
    return TSiteTemplate(
      desktop: EditBannerDesktopScreen(
        banner: banner,
      ),
      tablet: EditBannerTabletScreen(
        banner: banner,
      ),
      mobile: EditBannerMobileScreen(
        banner: banner,
      ),
    );
  }
}
