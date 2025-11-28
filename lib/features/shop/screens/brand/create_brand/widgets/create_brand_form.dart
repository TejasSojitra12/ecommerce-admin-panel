import 'package:e_commerce_admin_pannel/common/widgets/chips/rounded_choice_chips.dart';
import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/images/image_uploader.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/category/category_controller.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:e_commerce_admin_pannel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../controllers/brand/create_brand_controller.dart';

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateBrandController.instance;

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
                'Create New Brand',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Name Text Field
              TextFormField(
                controller: controller.name,
                validator: (value) => TValidator.validateEmptyText('Name', value),
                decoration: const InputDecoration(
                    labelText: 'Brand Name', prefixIcon: Icon(Iconsax.box)),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              // Categories
              Text(
                'Select Categories',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields / 2,
              ),
              Obx(
                ()=> Wrap(
                  spacing: TSizes.sm,
                  children: CategoryController.instance.allItems.map((element) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: TSizes.sm),
                      child: TChoiceChip(
                        text: element.name,
                        selected: controller.selectedCategories.contains(element),
                        onSelected: (value) => controller.toggleSelection(element),
                      ),
                    );
                  },).toList(),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              // Image Uploader & Featured Checkbox
              Obx(
                ()=> TImageUploader(
                  width: 80,
                  height: 80,
                  image: controller.imageURL.value.isNotEmpty ? controller.imageURL.value : TImages.defaultImage,
                  imageType: controller.imageURL.value.isNotEmpty ? ImageType.network : ImageType.asset,
                  onIconButtonPressed: () => controller.pickImage(),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              // Checkbox
              Obx(
                ()=> CheckboxMenuButton(
                    value: controller.isFeatured.value,
                    onChanged: (value) => controller.isFeatured.value = value ?? false,
                    child: const Text('Featured')),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.createBrand(), child: const Text('Create')),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),
            ],
          )),
    );
  }
}
