import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/category/category_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/category/edit_category_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/images/image_uploader.dart';
import '../../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';

class EditCategoryForm extends StatelessWidget {
  const EditCategoryForm({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = EditCategoryController.instance;
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
                'Update Category',
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
                  if (categoryController.isLoading.value) {
                    return TShimmerEffect(width: double.infinity, height: 55);
                  }

                  return DropdownButtonFormField<CategoryModel>(
                    value: controller.selectedParent.value.id.isNotEmpty ? controller.selectedParent.value : null,
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
                    image: controller.imageURL.value.isNotEmpty
                        ? controller.imageURL.value
                        : TImages.defaultImage,
                    imageType: controller.imageURL.value.isNotEmpty
                        ? ImageType.network
                        : ImageType.asset,
                    onIconButtonPressed: () => controller.pickImage(),
                  );
                },
              ),

              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              Obx(
                () => CheckboxMenuButton(
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
                    onPressed: () => controller.updateCategory(category),
                    child: const Text('Update')),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),
            ],
          )),
    );
  }
}
