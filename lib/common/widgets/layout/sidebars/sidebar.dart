import 'package:e_commerce_admin_pannel/common/widgets/images/t_circular_image.dart';
import 'package:e_commerce_admin_pannel/routes/routes.dart';
import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/personalization/controllers/settings_controller.dart';
import '../../../../utils/constants/enums.dart';
import 'menu/menu_item.dart';

class TSideBar extends StatelessWidget {
  const TSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
            color: TColors.white,
            border: Border(right: BorderSide(width: 1, color: TColors.grey))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Obx(
                    () => TCircularImage(
                      width: 100,
                      height: 100,
                      padding: 0,
                      margin: TSizes.sm,
                      backgroundColor: Colors.transparent,
                      image: SettingsController
                              .instance.setting.value.appLogo.isNotEmpty
                          ? SettingsController.instance.setting.value.appLogo
                          : TImages.darkAppLogo,
                      imageType: SettingsController
                              .instance.setting.value.appLogo.isNotEmpty
                          ? ImageType.network
                          : ImageType.asset,
                    ),
                  ),
                  Expanded(
                      child: Obx(
                    () => Text(
                      SettingsController.instance.setting.value.appName,
                      style: Theme.of(context).textTheme.headlineLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Padding(
                padding: const EdgeInsets.all(TSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('MENU',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(letterSpacingDelta: 1.2)),
                    const TMenuItem(
                      title: "Dashboard",
                      icon: Iconsax.status,
                      route: TRoutes.dashboard,
                    ),
                    const TMenuItem(
                      title: "Media",
                      icon: Iconsax.image,
                      route: TRoutes.media,
                    ),
                    const TMenuItem(
                      title: "Categories",
                      icon: Iconsax.category,
                      route: TRoutes.categories,
                    ),
                    const TMenuItem(
                      title: "Brands",
                      icon: Iconsax.dcube,
                      route: TRoutes.brands,
                    ),
                    const TMenuItem(
                      title: "Banners",
                      icon: Iconsax.picture_frame,
                      route: TRoutes.banners,
                    ),
                    const TMenuItem(
                      title: "Products",
                      icon: Iconsax.shop,
                      route: TRoutes.products,
                    ),
                    const TMenuItem(
                      title: "Customers",
                      icon: Iconsax.profile_2user,
                      route: TRoutes.customers,
                    ),
                    const TMenuItem(
                      title: "Orders",
                      icon: Iconsax.box,
                      route: TRoutes.orders,
                    ),
                    Text('OTHER',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(letterSpacingDelta: 1.2)),
                    const TMenuItem(
                      title: "Profile",
                      icon: Iconsax.user,
                      route: TRoutes.profile,
                    ),
                    const TMenuItem(
                      title: "Settings",
                      icon: Iconsax.setting_2,
                      route: TRoutes.settings,
                    ),
                    const TMenuItem(
                      title: "Logout",
                      icon: Iconsax.logout,
                      route: 'logout',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
