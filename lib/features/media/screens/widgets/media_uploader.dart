import 'dart:typed_data';

import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_admin_pannel/features/media/controllers/media_controller.dart';
import 'package:e_commerce_admin_pannel/features/media/models/image_model.dart';
import 'package:e_commerce_admin_pannel/features/media/screens/widgets/folder_dropdown.dart';
import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:e_commerce_admin_pannel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return Obx(
      () => controller.showImageUploaderSection.value
          ? Column(
              children: [
                /// Drag and Drop Area
                TRoundedContainer(
                  showBorder: true,
                  height: 250,
                  borderColor: TColors.borderPrimary,
                  backgroundColor: TColors.primaryBackground,
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            DropzoneView(
                              mime: const ['image/jpeg', 'image/png'],
                              cursor: CursorType.Default,
                              operation: DragOperation.copy,
                              onLoaded: () {},
                              onError: (e) => print('Zone error $e'),
                              onHover: () {},
                              onLeave: () {},
                              onCreated: (ctrl) {
                                controller.dropzoneViewController = ctrl;
                              },
                              onDropFile: (file) async {
                                final bytes = await controller
                                    .dropzoneViewController
                                    .getFileData(file);
                                final image = ImageModel(
                                  url: '',
                                  file: file,
                                  folder: '',
                                  filename: file.name,
                                  localImageToDisplay:
                                      Uint8List.fromList(bytes),
                                );
                                controller.selectedImagesToUpload.add(image);
                                if (file is String) {
                                  print("Zone Drop : $file");
                                } else {
                                  print(
                                      'Zone unknown type : ${file.runtimeType}');
                                }
                              },
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  TImages.defaultMultiImageIcon,
                                  width: 50,
                                  height: 50,
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwItems,
                                ),
                                const Text('Drag and Drop Images here'),
                                const SizedBox(
                                  height: TSizes.spaceBtwItems,
                                ),
                                OutlinedButton(
                                    onPressed: () =>
                                        controller.selectLocalImages(),
                                    child: const Text('Select Images'))
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                /// Locally Selected Images
                if (controller.selectedImagesToUpload.isNotEmpty)
                  TRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Folders Dropdown
                            Row(
                              children: [
                                // Folder Dropdown
                                Text(
                                  'Select Folder',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(
                                  width: TSizes.spaceBtwItems,
                                ),
                                MediaFolderDropdown(
                                  onChanged: (MediaCategory? newValue) {
                                    if (newValue != null) {
                                      controller.selectedPath.value = newValue;
                                    }
                                  },
                                ),
                              ],
                            ),

                            /// Remove All and Upload Button
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () => controller
                                        .selectedImagesToUpload
                                        .clear(),
                                    child: const Text('Remove All')),
                                const SizedBox(
                                  width: TSizes.spaceBtwItems,
                                ),
                                TDeviceUtils.isMobileScreen(context)
                                    ? const SizedBox.shrink()
                                    : SizedBox(
                                        width: TSizes.buttonWidth,
                                        child: ElevatedButton(
                                            onPressed: () => controller
                                                .uploadImageConfirmation(),
                                            child: const Text('Upload'))),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),
                        Wrap(
                          alignment: WrapAlignment.start,
                          spacing: TSizes.spaceBtwItems / 2,
                          runSpacing: TSizes.spaceBtwItems / 2,
                          children: controller.selectedImagesToUpload
                              .where(
                                (image) => image.localImageToDisplay != null,
                              )
                              .map(
                                (element) => Stack(
                                  children: [

                                    TRoundedImage(
                                      width: 90,
                                      height: 90,
                                      padding: TSizes.sm,
                                      imageType: ImageType.memory,
                                      memoryImage: element.localImageToDisplay,
                                      backgroundColor: TColors.primaryBackground,
                                    ),
                                    Positioned(top: 0,right: 0,
                                        child: IconButton(onPressed: (){
                                          controller.selectedImagesToUpload.remove(element);
                                        }, icon: const Icon(Iconsax.close_circle))),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),
                        TDeviceUtils.isMobileScreen(context)
                            ? SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () =>
                                        controller.uploadImageConfirmation(),
                                    child: const Text('Upload')),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
