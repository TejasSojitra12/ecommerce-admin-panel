import 'package:e_commerce_admin_pannel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/routes/routes.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:e_commerce_admin_pannel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/product/product_image_controller.dart';
import '../widgets/additional_images.dart';
import '../widgets/attributes_widget.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/brand_widget.dart';
import '../widgets/categories_widget.dart';
import '../widgets/product_type_widget.dart';
import '../widgets/stock_pricing_widget.dart';
import '../widgets/thumbnail_widget.dart';
import '../widgets/title_description.dart';
import '../widgets/variations_widget.dart';
import '../widgets/visibility_widget.dart';

class CreateProductMobileScreen extends StatelessWidget {
  const CreateProductMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductImageController());
    return Scaffold(
      bottomNavigationBar: ProductBottomNavigationButtons(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              TBreadcrumbsWithHeading(
                heading: 'Create Product',
                breadcrumbItems: [TRoutes.products, "Create Product"],
                returnToPreviousScreen: true,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Create Product
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductTitleAndDescription(),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  // Stock & Pricing
                  TRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Heading
                        Text(
                          'Stock & Pricing',
                          style:
                          Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),

                        // Product Type
                        ProductTypeWidget(),
                        SizedBox(
                          height: TSizes.spaceBtwInputFields,
                        ),

                        // Stock
                        ProductStockAndPricing(),
                        SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),

                        // Attributes
                        ProductAttribute(),
                        SizedBox(
                          height: TSizes.spaceBtwSections,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  // Variations
                  ProductVariations(),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  // Product Thumbnail
                  ProductThumbnailImage(),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  // Product Images
                  TRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("All Product Images",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall),
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        ProductAdditionalImages(additionalProductImagesURLs:controller.additionalProductImagesUrls,
                          onTapToAddImages: () => controller.selectMultipleProductImage(),
                          onTapToRemoveImage: (index) => controller.removeImage(index),),
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections,),

                  // Product Brand
                  ProductBrand(),
                  SizedBox(height: TSizes.spaceBtwSections,),

                  // Product Category
                  ProductCategories(),
                  SizedBox(height: TSizes.spaceBtwSections,),

                  // Product Visibility
                  ProductVisibilityWidget(),
                  SizedBox(height: TSizes.spaceBtwSections,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
