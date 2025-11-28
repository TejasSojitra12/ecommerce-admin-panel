import 'package:e_commerce_admin_pannel/features/shop/models/barnd_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/edit_brand_form.dart';
class EditBrandMobileScreen extends StatelessWidget{
  const EditBrandMobileScreen({super.key, required this.brand});
  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBreadcrumbsWithHeading(returnToPreviousScreen: true,heading: 'Update Brand', breadcrumbItems: [TRoutes.brands,'Update Brands']),
              const SizedBox(height: TSizes.spaceBtwSections,),

              // Form
              EditBrandForm(brand: brand,),
            ],
          ),),
      ),
    );
  }

}