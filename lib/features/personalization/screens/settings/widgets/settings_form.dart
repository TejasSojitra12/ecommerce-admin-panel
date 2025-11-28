import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/features/personalization/controllers/settings_controller.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:e_commerce_admin_pannel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller= SettingsController.instance;
    return Column(
      children: [
        TRoundedContainer(
          padding:
          EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'App Settings',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineMedium,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                // First And Last Name
                TextFormField(
                  controller: controller.appNameController,
                  decoration: InputDecoration(
                    hintText: 'App Name',
                    label: Text('App Name'),
                    prefixIcon: Icon(Iconsax.user),
                  ),

                ),
                SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),

                // Email and Phone
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                          controller: controller.taxRateController,
                          decoration: InputDecoration(
                            hintText: 'Tax (%)',
                            label: Text('Tax Rate (%)'),
                            prefixIcon: Icon(Iconsax.tag),
                          ),
                        )),
                    SizedBox(
                      width: TSizes.spaceBtwInputFields,
                    ),
                    // Last Name
                    Expanded(
                        child: TextFormField(
                          controller: controller.shippingCostController,
                          decoration: InputDecoration(
                            hintText: 'Shipping Cost',
                            label: Text('Shipping Cost (\$)'),
                            prefixIcon: Icon(Iconsax.ship),
                          ),
                        )),
                    SizedBox(
                      width: TSizes.spaceBtwInputFields,
                    ),
                    // Last Name
                    Expanded(
                        child: TextFormField(
                          controller: controller.freeShippingThresholdController,
                          decoration: InputDecoration(
                            hintText: 'Free Shipping After (\$)',
                            label: Text('Free Shipping After (\$)'),
                            prefixIcon: Icon(Iconsax.ship),
                          ),

                        ))
                  ],
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                SizedBox(
                  width: double.infinity,
                  child: Obx(
                    ()=> ElevatedButton(
                        onPressed: () => controller.isLoading.value ? (){}: controller.updateSettingInformation()
                        , child: controller.isLoading.value ? CircularProgressIndicator(color: Colors.white,strokeWidth: 2,) :
                    Text('Update App Settings')),
                  ),
                )
              ],
            ),
          ),
        ),

      ],
    );
  }
}
