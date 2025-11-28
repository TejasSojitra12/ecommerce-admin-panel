import 'package:e_commerce_admin_pannel/common/widgets/texts/page_heading.dart';
import 'package:e_commerce_admin_pannel/routes/routes.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TBreadcrumbsWithHeading extends StatelessWidget {
  const TBreadcrumbsWithHeading({super.key, required this.heading, required this.breadcrumbItems,  this.returnToPreviousScreen =false});

  // The heading for the page
  final String heading;

  // List of breadcrumbs items representing the navigation path
  final List<String> breadcrumbItems;

  // Flag indicating whether to include a button to return to the previous screen
  final bool returnToPreviousScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Breadcrumb trail
        Row(
          children: [
            // Dashboard link
            InkWell(
              onTap: () => Get.offAllNamed(TRoutes.dashboard),
              child: Padding(
                padding: const EdgeInsets.all(TSizes.xs),
                child: Text(
                  'Dashboard',
                  style:
                      Theme.of(context).textTheme.bodySmall!.apply(fontWeightDelta: -1),
                ),
              ),
            ),

            for(int i=0;i<breadcrumbItems.length;i++)
              Row(
                children: [
                  const Text('/'),// Separator
                  InkWell(
                    onTap: i==breadcrumbItems.length-1 ? null : ()=> Get.toNamed(breadcrumbItems[i]),
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.xs),
                      child: Text(
                        i==breadcrumbItems.length-1?breadcrumbItems[i].capitalize.toString(): capitalize(breadcrumbItems[i].substring(1)),
                        style:
                        Theme.of(context).textTheme.bodySmall!.apply(fontWeightDelta: -1),
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
        const SizedBox(
          height: TSizes.sm,
        ),
        // Heading of the page
        Row(
          children: [
            if(returnToPreviousScreen)IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.arrow_left)),
            if(returnToPreviousScreen)const SizedBox(width: TSizes.spaceBtwItems,),
            TPageHeading(heading: heading)
          ],
        )
      ],
    );
  }

  String capitalize(String s){
    return s.isEmpty ? '' : s[0].toUpperCase() +s.substring(1);
  }
}
