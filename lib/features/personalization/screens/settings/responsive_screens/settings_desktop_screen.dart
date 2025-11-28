import 'package:e_commerce_admin_pannel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:e_commerce_admin_pannel/features/personalization/screens/settings/widgets/settings_form.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../widgets/image_and_meta.dart';

class SettingsDesktopScreen extends StatelessWidget{
  const SettingsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BreadCrumbs
            TBreadcrumbsWithHeading(heading: 'Settings', breadcrumbItems: ['Settings']),
            SizedBox(height: TSizes.spaceBtwSections,),

            // Body
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Pic and meta
                Expanded(child: ImageAndMeta()),
                SizedBox(width: TSizes.spaceBtwSections,),

                // Form
                Expanded(flex: 2,child: SettingsForm()),
              ],
            )
          ],
        ),),
      ),
    );
  }

}