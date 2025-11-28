import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/shimmers/shimmer.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/category/category_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/create_product_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/category_model.dart';
import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:get/get.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesController = Get.put(CategoryController());

    if(categoriesController.allItems.isEmpty){
      categoriesController.fetchItems();
    }

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories label
          Text('Categories',style: Theme.of(context).textTheme.headlineSmall,),
          SizedBox(height: TSizes.spaceBtwItems,),

          // MultiSelectDialog for selecting Categories
          Obx(
            ()=> categoriesController.isLoading.value
              ?TShimmerEffect(width: double.infinity, height: 50)
               : MultiSelectDialogField(
              buttonText: Text('Select Categories'),
              title: Text('Categories'),
              items: categoriesController.allItems.map((element) =>  MultiSelectItem(element,element.name)).toList(),
              listType: MultiSelectListType.CHIP,
              selectedColor: TColors.primary,
              selectedItemsTextStyle: TextStyle(color: TColors.white),
              onConfirm: (values) {
                CreateProductController.instance.selectedCategories.assignAll(values);
              },
            ),
          )
        ],
      ),
    );
  }
}