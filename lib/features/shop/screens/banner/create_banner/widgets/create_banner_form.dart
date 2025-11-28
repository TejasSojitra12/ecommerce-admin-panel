import 'package:e_commerce_admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_admin_pannel/routes/app_screens.dart';
import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/banner/create_banner_controller.dart';

class CreateBannerForm extends StatelessWidget {
  const CreateBannerForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBannerController());
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              const SizedBox(
                height: TSizes.sm,
              ),
              Text(
                'Create New Banner',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Image Uploader & Featured Checkbox
              Column(
                children: [
                  GestureDetector(
                    child: Obx(
                      () => TRoundedImage(
                          width: 400,
                          height: 200,
                          backgroundColor: TColors.primaryBackground,
                          image: controller.imageURL.value.isNotEmpty
                              ? controller.imageURL.value
                              : TImages.defaultImage,
                          imageType: controller.imageURL.value.isNotEmpty
                              ? ImageType.network
                              : ImageType.asset),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TextButton(
                      onPressed: () => controller.pickImage(),
                      child: const Text('Select Image')),
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              Text(
                'Make Your Banner Active or InActive',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Obx(() => CheckboxMenuButton(
                  value: controller.isActive.value,
                  onChanged: (value) => controller.isActive.value = value ?? false,
                  child: const Text('Active'))),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              // Dropdown Menu Screen
              Obx(
                () => DropdownButton<String>(
                  value: controller.targetScreen.value,
                  hint: const Text('Select Screen'),
                  items: AppScreens.allAppScreenItems.map(
                    (e) {
                      return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e));
                    },
                  ).toList(),
                  onChanged: (String? value) =>
                      controller.targetScreen.value = value!,
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.createBanner(), child: const Text('Create')),
              ),

              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),
            ],
          )),
    );
  }
}
