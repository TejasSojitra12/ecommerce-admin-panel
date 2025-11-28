import 'package:e_commerce_admin_pannel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/dashboard/table/data_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/pie_chart.dart';
import '../widgets/weekly_sales.dart';

class DashboardMobileScreen extends StatelessWidget {
  const DashboardMobileScreen({super.key});

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
              // Heading
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Cards

              Obx(
                () => TDashboardCard(
                  title: 'Sales total',
                  subTitle: '\$${controller.orderController.allItems.fold(
                        0.0,
                        (previousValue, element) =>
                            previousValue + element.totalAmount,
                      ).toStringAsFixed(2)}',
                  stats: 25,
                ),
              ),
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Obx(
                () => TDashboardCard(
                  title: 'Average Order Value',
                  subTitle:
                      '\$${(controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount) / controller.orderController.allItems.length).toStringAsFixed(2)}',
                  stats: 15,
                ),
              ),
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Obx(
                () => TDashboardCard(
                  title: 'Total Orders',
                  subTitle: '\$${controller.orderController.allItems.length}',
                  stats: 44,
                ),
              ),
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Obx(
                () => TDashboardCard(
                  title: 'Visitors',
                  subTitle: '${controller.customerController.allItems.length}',
                  stats: 2,
                ),
              ),

              /// Bar Graph
              const TWeeklySalesGraph(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Orders
              const DashboardOrderTable(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Pie Chart
              const OrderStatusPieChart()
            ],
          ),
        ),
      ),
    );
  }
}
