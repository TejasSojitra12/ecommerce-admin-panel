import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/shimmers/shimmer.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/create_product_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/barnd_model.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/brand/brand_controller.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateProductController());
    final brandController = Get.put(BrandController());

    if(brandController.allItems.isEmpty){
      brandController.fetchItems();
    }
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand Label
          Text('Brand',style: Theme.of(context).textTheme.headlineSmall,),
          SizedBox(height: TSizes.spaceBtwItems,),

          // TypeAheadField for Brand Selection
          Obx(
            ()=> brandController.isLoading.value? TShimmerEffect(width: double.infinity, height: 50) : TypeAheadField(
              builder: (context, ctr, focusNode) {
                return TextFormField(
                  focusNode: focusNode,
                  controller: controller.brandTextField = ctr,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                    ),
                    labelText: 'Select Brand',
                    suffixIcon: Icon(Iconsax.box)
                  ),
                );
              },
              suggestionsCallback: (pattern) {
                return brandController.allItems.where((brand) => brand.name.contains(pattern),).toList();
              },
              itemBuilder: (context, value) {
                return ListTile(title: Text(value.name),);
              },
              onSelected: (suggestion) {
                controller.selectedBrand.value = suggestion;
                controller.brandTextField.text = suggestion.name;
              },
            ),
          )

        ],
      ),
    );
  }
}