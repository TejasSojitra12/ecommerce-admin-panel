import 'package:e_commerce_admin_pannel/common/widgets/images/image_uploader.dart';
import 'package:e_commerce_admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/create_product_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/product_image_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/product_variationModel.dart';
import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({super.key});

  @override
  Widget build(BuildContext context) {
    final variationController = ProductVariationController.instance;
    return Obx(
      ()=> CreateProductController.instance.productType.value == ProductType.variable ? TRoundedContainer(
        child: TRoundedContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Variation Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Product Variations",
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineSmall,
                  ),
                  TextButton(onPressed: () => variationController.removeVariation(context), child: Text('Remove Variations')),
                ],
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              // Variation List
              if(variationController.productVariations.isNotEmpty)
                ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                    itemCount: variationController.productVariations.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      final variation = variationController.productVariations[index];
                      return _buildVariationTile(context,index,variation,variationController);
                    })

           else
              _buildNoVariationsMessage(),

            ],
          ),
        ),
      ) : SizedBox.shrink(),
    );
  }

  Widget _buildVariationTile(BuildContext context, int index, ProductVariationModel variation, ProductVariationController variationController) {
    return ExpansionTile(
      backgroundColor: TColors.lightGrey,
      collapsedBackgroundColor: TColors.lightGrey,
      childrenPadding: EdgeInsets.all(TSizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
      title: Text(variation.attributeValue.entries.map((e) => '${e.key}: ${e.value}',).join(", ")),
      children: [

        Obx(()=>TImageUploader(
          right: 0,
          left: null,
          imageType: variation.image.value.isNotEmpty ? ImageType.network : ImageType.asset,
          image: variation.image.value.isNotEmpty ? variation.image.value : TImages.defaultImage,
          onIconButtonPressed: () => ProductImageController.instance.selectVariationImage(variation),
        )),
         SizedBox(height: TSizes.spaceBtwInputFields,),

        // Variation Stock and Pricing
        Row(
          children: [
            Expanded(child: TextFormField(
              controller: variationController.stockControllerList[index][variation],
              onChanged: (value) => variation.stock = int.parse(value),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(labelText: 'Stock',hintText: 'Add Stock, only numbers are allowed'),
            )),
            SizedBox(width: TSizes.spaceBtwInputFields,),
            Expanded(child: TextFormField(
              controller: variationController.priceControllerList[index][variation],
              onChanged: (value) => variation.price = double.parse(value),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))],
              decoration: InputDecoration(labelText: 'Price',hintText: 'Price with up-to 2 decimals'),
            )),
            SizedBox(width: TSizes.spaceBtwInputFields,),
            Expanded(child: TextFormField(
              controller: variationController.salePriceControllerList[index][variation],
              onChanged: (value) => variation.salePrice = double.parse(value),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))],
              decoration: InputDecoration(labelText: 'DicountedPrice',hintText: 'Price with up-to 2 decimals'),
            )),
          ],
        ),
        SizedBox(height: TSizes.spaceBtwInputFields,),

        // Variation Description
        TextFormField(
          controller: variationController.descriptionControllerList[index][variation],
          onChanged: (value) => variation.description = value,
          decoration: InputDecoration(labelText: 'Description',hintText: 'Add description of this variation...'),
        ),
        SizedBox(height: TSizes.spaceBtwSections,),
      ],
    );
  }

  Widget _buildNoVariationsMessage() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TRoundedImage(imageType: ImageType.asset,
              width: 200,
              height: 200,
              image: TImages.defaultVariationImageIcon,)
          ],
        ),
        SizedBox(height: TSizes.spaceBtwItems,),
        Text('There are no Variation added for this product'),
      ],
    );
  }

}
