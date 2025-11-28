
import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/product/product_image_controller.dart';
import '../../../../models/product_model.dart';
import 'package:get/get.dart';

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

class EditProductMobileScreen extends StatelessWidget{
  const EditProductMobileScreen({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductImageController());
    return Scaffold(
      bottomNavigationBar: ProductBottomNavigationButtons(product: product,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              TBreadcrumbsWithHeading(
                heading: 'Edit Product',
                breadcrumbItems: [TRoutes.products, "Edit Product"],
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
                  ProductCategories(product: product,),
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