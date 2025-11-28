import 'package:e_commerce_admin_pannel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/data_table/table_header.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/customer/customer_detail_controller.dart';
import 'package:e_commerce_admin_pannel/routes/routes.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../authentication/models/user/user_model.dart';
import '../../../../../personalization/models/user_model.dart';
import '../../../../controllers/customer/customer_controller.dart';
import '../table/data_table.dart';
import '../widgets/customer_info.dart';
import '../widgets/customer_orders.dart';
import '../widgets/shipping_address.dart';

class CustomerDetailDesktopScreen extends StatelessWidget {
  final UserModel customer;

  const CustomerDetailDesktopScreen({super.key,required this.customer});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    controller.customer.value = customer;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            // Breadcrumbs
             TBreadcrumbsWithHeading(heading: customer.fullName, breadcrumbItems: [TRoutes.customers,'Details'],returnToPreviousScreen: true,),
            const SizedBox(height: TSizes.spaceBtwSections,),

            // Body
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Side Customer Information
                Expanded(
                  child: Column(
                    children: [
                      // Customer Info
                      CustomerInfo(customer: customer,),
                      const SizedBox(height: TSizes.spaceBtwSections,),

                      // Shipping Address
                      const ShippingAddress(),
                    ],
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwSections,),

                // Right Side Customer Orders Table
                const Expanded(flex:2,child: CustomerOrders()),
              ],
            )
          ],
        ),
        ),
      ),
    );
  }
}
