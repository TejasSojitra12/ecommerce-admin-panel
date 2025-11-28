import 'package:e_commerce_admin_pannel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:e_commerce_admin_pannel/features/media/controllers/media_controller.dart';
import 'package:e_commerce_admin_pannel/features/media/screens/widgets/media_content.dart';
import 'package:e_commerce_admin_pannel/features/media/screens/widgets/media_uploader.dart';
import 'package:e_commerce_admin_pannel/routes/routes.dart';
import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MediaDesktopScreen extends StatelessWidget {
  const MediaDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Breadcrumb
                  const TBreadcrumbsWithHeading(
                    heading: 'Media',
                    breadcrumbItems: [ TRoutes.media],
                  ),

                  SizedBox(
                    width: TSizes.buttonWidth * 1.5,
                    child: ElevatedButton.icon(
                      onPressed: () => controller.showImageUploaderSection.value=!controller.showImageUploaderSection.value,
                      icon: const Icon(Iconsax.cloud_add,color: TColors.white,),
                      label: const Text('Upload Images'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Upload Area
              const MediaUploader(),

              /// Media
              MediaContent(allowMultipleSelection: false,allowSelection: false,),
            ],
          ),
        ),
      ),
    );
  }
}
