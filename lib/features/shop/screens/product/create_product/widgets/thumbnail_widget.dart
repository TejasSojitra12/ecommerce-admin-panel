import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/product_image_controller.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/colors.dart';

class ProductThumbnailImage extends StatelessWidget {
  const ProductThumbnailImage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProductImageController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Thumbnail Text
          Text('Product Thumbnail', style: Theme
              .of(context)
              .textTheme
              .headlineSmall,),
          SizedBox(height: TSizes.spaceBtwItems,),

          // Container for Product Thumbnail
          TRoundedContainer(
            height: 300,
            backgroundColor: TColors.primaryBackground,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Thumbnail Image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Obx(
                        ()=> TRoundedImage(
                            imageType: controller.selectedThumbnailImageUrl.value == null ?  ImageType.asset : ImageType.network, width: 220, height: 220,
                          image: controller.selectedThumbnailImageUrl.value ?? TImages.defaultSingleImageIcon,
                            ),
                      ))
                    ],
                  ),
                  
                  // Add Thumbnail Button
                  SizedBox(width: 200,child: OutlinedButton(onPressed: ()=> controller.selectThumbnailImage(), child: Text('Add Thumbnail')),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}