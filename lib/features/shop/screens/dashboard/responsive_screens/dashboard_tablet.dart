import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../controllers/dashboard/dashboard_controller.dart';
import '../table/data_table.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/pie_chart.dart';
import '../widgets/weekly_sales.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Heading
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => TDashboardCard(
                            title: 'Sales total',
                            subTitle:
                                '\$${controller.orderController.allItems.fold(
                                      0.0,
                                      (previousValue, element) =>
                                          previousValue + element.totalAmount,
                                    ).toStringAsFixed(2)}',
                            stats: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      Expanded(
                        child: Obx(
                          () => TDashboardCard(
                            title: 'Average Order Value',
                            subTitle:
                                '\$${(controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount) / controller.orderController.allItems.length).toStringAsFixed(2)}',
                            stats: 15,
                          ),
                        ),
                      ),
                    ],
                  ),

              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
            
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => TDashboardCard(
                            title: 'Total Orders',
                            subTitle:
                                '\$${controller.orderController.allItems.length}',
                            stats: 44,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      Expanded(
                        child: Obx(
                          () => TDashboardCard(
                            title: 'Visitors',
                            subTitle:
                                '${controller.customerController.allItems.length}',
                            stats: 2,
                          ),
                        ),
                      ),
                    ],
                  ),

              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),



              /// Bar Graph
              const TWeeklySalesGraph(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Orders
              TRoundedContainer(child: DashboardOrderTable()),

              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Pie Chart
              TRoundedContainer(child: const OrderStatusPieChart())
            ],
          ),
        ),
      ),
    );
  }
}
