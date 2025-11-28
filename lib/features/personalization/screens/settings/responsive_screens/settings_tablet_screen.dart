import 'package:e_commerce_admin_pannel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../widgets/image_and_meta.dart';
import '../widgets/settings_form.dart';

class SettingsTabletScreen extends StatelessWidget{
  const SettingsTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BreadCrumbs
              TBreadcrumbsWithHeading(heading: 'Settings', breadcrumbItems: ['Settings']),

              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Body
              // Profile Pic and meta
              ImageAndMeta(),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Form
              SettingsForm(),
            ],
          ),
        ),
      ),
    );
  }

}