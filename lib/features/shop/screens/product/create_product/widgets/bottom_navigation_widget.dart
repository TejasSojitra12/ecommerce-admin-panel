import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/create_product_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductBottomNavigationButtons extends StatelessWidget {
  const ProductBottomNavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;
    return TRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Discard Button
          OutlinedButton(onPressed: (){}, child: Text('Discard')),
          const SizedBox(width: TSizes.spaceBtwItems/2,),

          // Save Changes Button
          SizedBox(width: 160,child: ElevatedButton(onPressed: ()=> controller.createProduct(), child: Text('Save Changes'))),
        ],
      ),
    );
  }
}