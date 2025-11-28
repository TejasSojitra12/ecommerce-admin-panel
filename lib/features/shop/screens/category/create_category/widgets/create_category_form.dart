import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/images/image_uploader.dart';
import 'package:e_commerce_admin_pannel/common/widgets/loaders/loader_animation.dart';
import 'package:e_commerce_admin_pannel/common/widgets/shimmers/shimmer.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/category/create_category_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/category_model.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:e_commerce_admin_pannel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../../../../controllers/category/category_controller.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateCategoryController.instance;
    final categoryController = Get.put(CategoryController());
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
                'Create New Category',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Name TextField
              TextFormField(
                controller: controller.name,
                validator: (value) =>
                    TValidator.validateEmptyText('Name', value),
                decoration: const InputDecoration(
                    labelText: 'Category Name',
                    prefixIcon: Icon(Iconsax.category)),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              Obx(
                () {
                  if(categoryController.isLoading.value){
                    return TShimmerEffect(width: double.infinity, height: 55);
                  }

                  return DropdownButtonFormField(
                  decoration: const InputDecoration(
                      hintText: 'Parent Category',
                      labelText: 'Parent Category',
                      prefixIcon: Icon(Iconsax.bezier)),
                  items: categoryController.allItems.map(
                    (element) {
                      return DropdownMenuItem(
                          value: element,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [Text(element.name)],
                          ));
                    },
                  ).toList(),
                  onChanged: (CategoryModel? value) {
                    if (value != null) {
                      controller.selectedParent.value = value;
                    }
                  },
                );
                },
              ),

              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),
              Obx(
                () {
                  return TImageUploader(
                  width: 80,
                  height: 80,
                  image: controller.imageURL.value.isNotEmpty ? controller.imageURL.value : TImages.defaultImage,
                  imageType: controller.imageURL.value.isNotEmpty ? ImageType.network:ImageType.asset,
                  onIconButtonPressed: () => controller.pickImage(),
                );
                },
              ),

              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              Obx(
                ()=> CheckboxMenuButton(
                  value: controller.isFeatured.value,
                  onChanged: (value) {
                    controller.isFeatured.value = value ?? false;
                  },
                  child: const Text('Featured'),
                ),
              ),

              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () =>controller.createCategory(), child: const Text('Create')),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),
            ],
          )),
    );
  }
}
