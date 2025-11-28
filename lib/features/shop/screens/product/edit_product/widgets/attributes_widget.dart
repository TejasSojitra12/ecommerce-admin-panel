import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/create_product_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/product_attribute_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:e_commerce_admin_pannel/utils/device/device_utility.dart';
import 'package:e_commerce_admin_pannel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../controllers/product/edit_product_controller.dart';

class ProductAttribute extends StatelessWidget {
  const ProductAttribute({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = EditProductController.instance;
    final attributeController = Get.put(ProductAttributeController());
    final variationController = Get.put(ProductVariationController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       // Divider Based on product Type
        Obx((){
          return productController.productType.value == ProductType.single ? Column(
            children: [
              Divider(
                color: TColors.primaryBackground,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
            ],
          ):SizedBox.shrink();
        }),

        Text(
          'Add Product Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        // Form to add new Attribute
        Form(
          key: attributeController.attributesFormKey,
            child: TDeviceUtils.isDesktopScreen(context)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildAttributeName(attributeController)),
                      SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      Expanded(flex: 2, child: _buildAttributeTextField(attributeController)),
                      SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      _buildAddAttributeButton(attributeController),
                    ],
                  )
                : Column(
                    children: [
                      _buildAttributeName(attributeController),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      _buildAttributeTextField(attributeController),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      _buildAddAttributeButton(attributeController),
                    ],
                  )),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        // List of added attributes
        Text(
          "All Attributes",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        // Display added attributes in a rounded container
        TRoundedContainer(
          backgroundColor: TColors.primaryBackground,
          child: Obx(() => attributeController.productAttributes.isNotEmpty
            ? buildAttributesList(context,attributeController):buildEmptyAttributes(),)
        ),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        // Generate Variations Button
        Obx(
          ()=> productController.productType.value == ProductType.variable && variationController.productVariations.isEmpty ?  Center(
            child: SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                onPressed: () => variationController.generateVariationsConfirmation(context),
                label: Text('Generate Variations'),
                icon: Icon(Iconsax.activity),
              ),
            ),
          ) : SizedBox.shrink(),
        )
      ],
    );
  }

  TextFormField _buildAttributeName(ProductAttributeController attributeController) {
    return TextFormField(
      controller: attributeController.attributeName,
      validator: (value) =>
          TValidator.validateEmptyText("Attribute Name", value),
      decoration: const InputDecoration(
        labelText: 'Attribute Name',
        hintText: 'Colors, Sizes, Material',
      ),
    );
  }

  SizedBox _buildAttributeTextField(ProductAttributeController attributeController) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        controller: attributeController.attributes,
        expands: true,
        maxLines: null,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        validator: (value) =>
            TValidator.validateEmptyText('Attributes Field', value),
        decoration: InputDecoration(
          labelText: 'Attributes',
          hintText: 'Add attributes separated by | Example: Red | Blue | Green',
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  SizedBox _buildAddAttributeButton(ProductAttributeController attributeController) {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () => attributeController.addNewAttribute(),
        icon: Icon(Iconsax.add),
        label: Text("Add"),
        style: ElevatedButton.styleFrom(
          foregroundColor: TColors.black,
          backgroundColor: TColors.secondary,
          side: BorderSide(color: TColors.secondary),
        ),
      ),
    );
  }

  ListView buildAttributesList(BuildContext context,ProductAttributeController attributeController) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: TColors.white,
              borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
            ),
            child: ListTile(
              title: Text(attributeController.productAttributes[index].name ?? ''),
              subtitle: Text(attributeController.productAttributes[index].values!.map((e) => e.trim(),).toString()),
              trailing: IconButton(
                  onPressed: () =>attributeController.removeAttribute(index, context),
                  icon: Icon(
                    Iconsax.trash,
                    color: TColors.error,
                  )),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
              height: TSizes.spaceBtwItems,
            ),
        shrinkWrap: true,
        itemCount: attributeController.productAttributes.length);
  }

  Column buildEmptyAttributes() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TRoundedImage(
              width: 150,
              height: 80,
              imageType: ImageType.asset,
              image: TImages.defaultAttributeColorsImageIcon,
            )
          ],
        ),
        SizedBox(height: TSizes.spaceBtwItems,),
        Text('There are no attribute added for this product')
      ],
    );
  }
}
