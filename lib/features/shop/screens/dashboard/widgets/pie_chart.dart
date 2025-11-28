import 'package:e_commerce_admin_pannel/common/widgets/containers/circular_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/loaders/loader_animation.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/device/device_utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/dashboard/dashboard_controller.dart';

class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Status',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        // Graph
        Obx(
          () => controller.orderStatusData.isNotEmpty
              ? SizedBox(
                  height: 400,
                  child: PieChart(PieChartData(
                    sectionsSpace: 2,
                      centerSpaceRadius: TDeviceUtils.isTabletScreen(context) ? 80 : 55,
                      startDegreeOffset: 180,
                      sections: controller.orderStatusData.entries.map(
                        (e) {
                          final status = e.key;
                          final count = e.value;

                          return PieChartSectionData(
                            showTitle: true,
                              title: '$count',
                              value: count.toDouble(),
                              radius:TDeviceUtils.isTabletScreen(context) ? 80 : 100,
                              color:
                                  THelperFunctions.getOrderStatusColor(status),
                              titleStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white));
                        },
                      ).toList(),
                      pieTouchData: PieTouchData(
                        touchCallback:
                            (FlTouchEvent event, pieTouchResponse) {},
                        enabled: true,
                      ))),
                )
              : SizedBox(
                  height: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TLoaderAnimation(),
                    ],
                  ),
                ),
        ),

        // Show Status and Colour Meta
        SizedBox(
          width: double.infinity,
          child: Obx(
            ()=> DataTable(
                horizontalMargin: 0,
                columns: const [
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Orders')),
                  DataColumn(label: Text('Total')),
                ],
                rows: controller.orderStatusData.entries.map(
                  (e) {
                    final OrderStatus status = e.key;
                    final int count = e.value;
                    final totalAmount = controller.totalAmounts[status] ?? 0;
                    return DataRow(cells: [
                      DataCell(Row(
                        children: [
                          TCircularContainer(
                            width: 20,
                            height: 20,
                            backgroundColor:
                                THelperFunctions.getOrderStatusColor(status),
                          ),
                          Expanded(
                              child: Text(
                                  ' ${controller.getDisplayStatusName(status)}'))
                        ],
                      )),
                      DataCell(Text(count.toString())),
                      DataCell(Text('\$${totalAmount.toStringAsFixed(2)}')),
                    ]);
                  },
                ).toList()),
          ),
        ),
      ],
    );
  }
}
