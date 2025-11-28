import 'package:e_commerce_admin_pannel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/data_table/table_header.dart';
import 'package:e_commerce_admin_pannel/common/widgets/loaders/loader_animation.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/banner/banner_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/banner/all_banners/table/data_table.dart';
import 'package:e_commerce_admin_pannel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/sizes.dart';

class BannerDesktopScreen extends StatelessWidget {
  const BannerDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BannerController.instance;
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      // Breadcrumbs
                      const TBreadcrumbsWithHeading(heading: 'Banners', breadcrumbItems: ['Banners']),
                      const SizedBox(height: TSizes.spaceBtwSections,),


                           TRoundedContainer(
                          child: Column(
                            children: [
                              // Table Header
                              TTableHeader(buttonText: 'Create Banner',onPressed: ()=>Get.toNamed(TRoutes.createBanner),),
                              const SizedBox(height: TSizes.spaceBtwItems,),

                              // Table
                              Obx(() {
                                if(controller.isLoading.value) return TLoaderAnimation();

                                return const BannerTable();
                              }),
                            ],
                          ),
                        ),

                    ]
                )
            )
        )
    );
  }

}