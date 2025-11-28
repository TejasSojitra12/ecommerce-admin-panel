import 'package:e_commerce_admin_pannel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/category_model.dart';
import 'package:e_commerce_admin_pannel/routes/routes.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../widgets/edit_category_form.dart';

class EditCategoryDesktopScreen extends StatelessWidget{
  const EditCategoryDesktopScreen({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BreadCrumbs
            const TBreadcrumbsWithHeading(returnToPreviousScreen: true,heading: 'Update Category', breadcrumbItems: [TRoutes.categories,'Update Category']),
            const SizedBox(height: TSizes.spaceBtwSections,),

            // Form
            EditCategoryForm(category: category,),
          ],
        ),),
      ),
    );
  }

}