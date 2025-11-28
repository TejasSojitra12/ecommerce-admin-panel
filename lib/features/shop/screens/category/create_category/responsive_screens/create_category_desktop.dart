
import 'package:e_commerce_admin_pannel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/category/create_category_controller.dart';
import 'package:e_commerce_admin_pannel/routes/routes.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../widgets/create_category_form.dart';

class CreateCategoryDesktopScreen extends StatelessWidget{
  const   CreateCategoryDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateCategoryController.instance;
   return const Scaffold(
     body: SingleChildScrollView(
       child:  Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           TBreadcrumbsWithHeading(returnToPreviousScreen: true,heading: 'Create Category', breadcrumbItems: [TRoutes.categories,'Create Category']),
           SizedBox(height: TSizes.spaceBtwSections,),

           // Form
           CreateCategoryForm()
         ],
       ),),
     ),
   );
  }

}