import 'package:e_commerce_admin_pannel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/data_table/table_header.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../controllers/customer/customer_controller.dart';
import '../table/data_table.dart';

class CustomerMobileScreen extends StatelessWidget{
  const CustomerMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerController.instance;

    return Scaffold(
      body: SingleChildScrollView(
        child:  Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Breadcrumbs
              TBreadcrumbsWithHeading(heading: 'Customers', breadcrumbItems: ['Customers']),
              SizedBox(height: TSizes.spaceBtwSections,),

              TRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    TTableHeader(
                      showLeftWidget: false,
                      searchController: controller.searchTextController,
                      searchOnChange: (query) => controller.searchQuery(query),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems,),

                    // Table
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const TLoaderAnimation();
                      }
                      return CustomerTable();
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

  }

}