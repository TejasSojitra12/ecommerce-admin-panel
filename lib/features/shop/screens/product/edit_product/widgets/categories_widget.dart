import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/shimmers/shimmer.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/category/category_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/create_product_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/category_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/product_model.dart';
import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:e_commerce_admin_pannel/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:get/get.dart';

import '../../../../controllers/product/edit_product_controller.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key, required this.product});
  
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productController = EditProductController.instance;


    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories label
          Text('Categories',style: Theme.of(context).textTheme.headlineSmall,),
          SizedBox(height: TSizes.spaceBtwItems,),

          FutureBuilder(
            future: Future.wait([
              productController.loadSelectedCategories(product.id),
            ]),
            builder: (context, snapshot) {
              final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
              if (widget != null) return widget;

              return Obx(() => MultiSelectDialogField(
                buttonText: Text('Select Categories'),
                title: Text('Categories'),

                /// FIXED: Show all categories
                items: CategoryController.instance.allItems
                    .map((element) => MultiSelectItem(element, element.name))
                    .toList(),

                listType: MultiSelectListType.CHIP,

                selectedColor: TColors.primary,
                selectedItemsTextStyle: TextStyle(color: TColors.white),

                /// FIXED: Set selected categories
                initialValue: productController.selectedCategories, // <--- IMPORTANT

                /// Save selected categories
                onConfirm: (values) {
                  productController.selectedCategories.assignAll(values);
                },
              ));
            },
          )

        ],
      ),
    );
  }
}