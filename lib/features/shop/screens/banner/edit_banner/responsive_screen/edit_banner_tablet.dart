import 'package:e_commerce_admin_pannel/features/shop/screens/banner/edit_banner/widgets/edit_banner_form.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../models/banner_model.dart';

class EditBannerTabletScreen extends StatelessWidget{
  const EditBannerTabletScreen({super.key, required this.banner});
  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment:   CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              TBreadcrumbsWithHeading(returnToPreviousScreen: true,heading: 'Create Banner', breadcrumbItems: [TRoutes.banners,'Update Banner']),
              SizedBox(height: TSizes.spaceBtwSections,),

              // Form
              EditBannerForm(banner: banner,),
            ],
          ),
        ),
      ),
    );
  }

}