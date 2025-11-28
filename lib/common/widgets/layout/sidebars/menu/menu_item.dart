import 'package:e_commerce_admin_pannel/common/widgets/layout/sidebars/sidebar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class TMenuItem extends StatelessWidget {
  const TMenuItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.route});

  final String route;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(SideBarController());
    return InkWell(
      onTap: () => menuController.menuOnTap(route),
      onHover: (hovering) => hovering
          ? menuController.changeHoverItem(route)
          : menuController.changeHoverItem(''),
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
              color: menuController.isHovering(route) ||
                      menuController.isActive(route)
                  ? TColors.primary
                  : Colors.transparent,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: TSizes.lg,
                      right: TSizes.md,
                      top: TSizes.md,
                      bottom: TSizes.md),
                  child: menuController.isActive(route)
                      ? Icon(icon, size: 22, color: TColors.white)
                      : Icon(
                          icon,
                          size: 22,
                          color: menuController.isHovering(route)
                              ? TColors.white
                              : TColors.darkGrey,
                        ),
                ),
                if (menuController.isHovering(route) ||
                    menuController.isActive(route))
                  Flexible(
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: TColors.white),
                    ),
                  )
                else
                  Flexible(
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: TColors.darkGrey),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
