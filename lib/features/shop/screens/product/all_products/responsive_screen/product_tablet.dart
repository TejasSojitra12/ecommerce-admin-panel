import 'package:e_commerce_admin_pannel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/data_table/table_header.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/product/all_products/table/data_table.dart';
import 'package:e_commerce_admin_pannel/routes/routes.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/product/product_controller.dart';

class ProductTabletScreen extends StatelessWidget{
  const ProductTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumb
            TBreadcrumbsWithHeading(heading: 'Products', breadcrumbItems: ['Products']),
            SizedBox(height: TSizes.spaceBtwSections,),

            // Table
            TRoundedContainer(
              child: Column(
                children: [
                  // Table Header
                  TTableHeader(
                    buttonText: 'Add Product',
                    onPressed: () => Get.toNamed(TRoutes.createProduct),
                    searchController: controller.searchTextController,
                    searchOnChange: (value) => controller.searchQuery(value),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  // Body
                  Obx(() {
                    if(controller.isLoading.value)
                      return const Center(child: CircularProgressIndicator(),);

                    return ProductTable();
                  }),
                ],
              ),
            )
          ],
        ),),
      ),
    );
  }

}