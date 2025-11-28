import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/create_product_controller.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({
    super.key,
  });
  @override
  Widget build (BuildContext context) {
    final controller = CreateProductController.instance;
    return Obx(
      ()=> Row(
        children: [
          Text('Product Type', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(width: TSizes.spaceBtwItems),

          // Radio button for Single Product Type
          RadioMenuButton<ProductType>(
            value: ProductType.single,
            groupValue: controller.productType.value,
            onChanged: (value) => controller.productType.value = value!,
            child: const Text('Single'),
          ),

          RadioMenuButton<ProductType>(
            value: ProductType.variable,
            groupValue: controller.productType.value,
            onChanged: (value) => controller.productType.value = value!,
            child: const Text('Variable'),
          ),

        ],
      ),
    ); // Row
  }
}