import 'package:clipboard/clipboard.dart';
import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_admin_pannel/features/media/controllers/media_controller.dart';
import 'package:e_commerce_admin_pannel/features/media/models/image_model.dart';
import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:e_commerce_admin_pannel/utils/device/device_utility.dart';
import 'package:e_commerce_admin_pannel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ImagePopup extends StatelessWidget {
  final ImageModel image;

  const ImagePopup({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return SingleChildScrollView(
      child: Dialog(
        // Shape of dialog
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
        child: TRoundedContainer(
          width: TDeviceUtils.isDesktopScreen(context)
               ?MediaQuery.of(context).size.width * 0.4
              : double.infinity,
          padding: const EdgeInsets.all(TSizes.spaceBtwItems),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Stack(
                  children: [
                    TRoundedContainer(
                      backgroundColor: TColors.primaryBackground,
                      child: TRoundedImage(
                        image: image.url,
                        applyImageRadius: true,
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: TDeviceUtils.isDesktopScreen(context)
                            ? MediaQuery.of(context).size.width * 0.4
                            : double.infinity,
                        imageType: ImageType.network,
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(Iconsax.close_circle)))
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              // Display the various meta data about image
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Image Name:',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
                  Expanded(
                      flex: 3,
                      child: Text(
                        image.filename,
                        style: Theme.of(context).textTheme.titleLarge,
                      )),
                ],
              ),

              // Display image url with option to copy it
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Image Url:',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
                  Expanded(
                      flex: 2,
                      child: Text(
                        image.url,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                            FlutterClipboard.copy(image.url).then(
                              (value) =>
                                  TLoaders.customToast(message: 'URL copied!'),
                            );
                          },
                          child: const Text('copy URL')))
                ],
              ),

              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextButton(
                        onPressed: () => controller.removeCloudImageConfirmation(image),
                        child: const Text(
                          'Delete Image',
                          style: TextStyle(color: Colors.red),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
