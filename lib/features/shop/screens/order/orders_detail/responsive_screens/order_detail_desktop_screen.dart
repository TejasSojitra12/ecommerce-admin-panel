import 'package:e_commerce_admin_pannel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/data_table/table_header.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/order_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/order/orders_detail/widgets/order_customer.dart';
import 'package:e_commerce_admin_pannel/routes/routes.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../table/data_table.dart';
import '../widgets/order_info.dart';
import '../widgets/order_items.dart';
import '../widgets/order_transaction.dart';

class OrderDetailDesktopScreen extends StatelessWidget {
  final OrderModel order;
  const OrderDetailDesktopScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:  Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            // Breadcrumbs
            TBreadcrumbsWithHeading(heading: order.id,breadcrumbItems: [TRoutes.orders,'Details'],returnToPreviousScreen: true,),
            SizedBox(height: TSizes.spaceBtwSections,),

            // Body
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2,child:Column(
                  children: [
                    // Order Info
                    OrderInfo(order: order,),
                    SizedBox(height: TSizes.spaceBtwSections,),

                    // Items
                    OrderItems(order: order,),
                    SizedBox(height: TSizes.spaceBtwSections,),

                    // Transaction
                    OrderTransaction(order: order,),
                  ],
                ) ),
                SizedBox(width: TSizes.spaceBtwSections,),
                Expanded(child: Column(
                  children: [

                    // Customer Info
                    OrderCustomerInfo(order: order,),
                    SizedBox(height: TSizes.spaceBtwSections,),
                  ],
                )),
              ],
            )

          ],
        ),
        ),
      ),
    );
  }
}
