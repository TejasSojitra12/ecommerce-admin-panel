import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductVisibilityWidget extends StatelessWidget{
  const ProductVisibilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // return TRoundedContainer(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       // Visibility Header
    //       Text(
    //         'Visibility',
    //         style: Theme.of(context).textTheme.headlineSmall,
    //       ),
    //       SizedBox(height: TSizes.spaceBtwItems,),
    //
    //       // Radio buttons for visibility
    //       Column(
    //         children: [
    //           _buildVisibilityRadioButton(ProductVisibility.published, 'Published'),
    //           _buildVisibilityRadioButton(ProductVisibility.hidden, 'Hidden')
    //         ],
    //       )
    //     ],
    //   ),
    // );
    return SizedBox.shrink();

  }

  Widget _buildVisibilityRadioButton(ProductVisibility value, String label){
    return RadioMenuButton<ProductVisibility>(
      value: value,
      groupValue: ProductVisibility.published,
      onChanged: (value) {
        
      },
      child: Text(label),
    );
  }
}