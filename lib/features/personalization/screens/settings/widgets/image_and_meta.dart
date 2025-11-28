import 'package:e_commerce_admin_pannel/features/personalization/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/images/image_uploader.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class ImageAndMeta extends StatelessWidget {
  const ImageAndMeta({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    return TRoundedContainer(
        padding: const EdgeInsets.symmetric(
            vertical: TSizes.lg, horizontal: TSizes.md),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(
            children: [
              // User Image
               Obx(
                 ()=> TImageUploader(
                  right: 10,
                  bottom: 20,
                  left: null,
                  width: 200,
                  height: 200,
                  circular: true,
                  icon: Iconsax.camera,
                  loading: controller.isLoading.value,
                  onIconButtonPressed: () => controller.updateAppLogo(),
                  imageType: controller.setting.value.appLogo.isNotEmpty ? ImageType.network : ImageType.asset,
                  image: controller.setting.value.appLogo.isNotEmpty ? controller.setting.value.appLogo : TImages.user,
                               ),
               ),

              const SizedBox(height: TSizes.spaceBtwItems),
              Obx(
                ()=> Text(controller.setting.value.appName,
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ), // Column
        ]));
  }
}
