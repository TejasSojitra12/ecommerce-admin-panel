import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/product_image_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/dashboard/table/data_table.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/dashboard/widgets/weekly_sales.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/dashboard_card.dart';
import '../widgets/pie_chart.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADING
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// CARDS
               Row(
                children: [
                  Expanded(
                    child: Obx(
                      ()=> TDashboardCard(
                        title: 'Sales total',
                        subTitle: '\$${controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount,).toStringAsFixed(2)}',
                        stats: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Expanded(
                    child: Obx(
                      ()=> TDashboardCard(
                        title: 'Average Order Value',
                        subTitle: '\$${(controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount)/ controller.orderController.allItems.length).toStringAsFixed(2)}',
                        stats: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Expanded(
                    child: Obx(
                      ()=> TDashboardCard(
                        title: 'Total Orders',
                        subTitle: '\$${controller.orderController.allItems.length}',
                        stats: 44,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Expanded(
                    child: Obx(
                      ()=> TDashboardCard(
                        title: 'Visitors',
                        subTitle: '${controller.customerController.allItems.length}',
                        stats: 2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// GRAPHS
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        /// Bar Graph
                        TWeeklySalesGraph(),
                        SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),

                        /// Orders
                        TRoundedContainer(child: DashboardOrderTable()),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: TSizes.spaceBtwSections,
                  ),

                  /// Pie Chart
                  Expanded(
                      child: TRoundedContainer(
                    child: OrderStatusPieChart(),
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
