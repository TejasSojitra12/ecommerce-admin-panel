import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/shimmers/shimmer.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/order_model.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:e_commerce_admin_pannel/utils/device/device_utility.dart';
import 'package:e_commerce_admin_pannel/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/order/order_controller.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    controller.orderStatus.value = order.status;
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Text(
            'Order Information',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          // Order Details
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date"),
                    Text(
                      order.formattedOrderDate,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Items"),
                    Text(
                      '${order.items.length} length',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: TDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Status"),
                    Obx(
                      () {
                        if(controller.statusLoader.value) return TShimmerEffect(width: double.infinity, height: 55);
                        return TRoundedContainer(
                        radius: TSizes.cardRadiusSm,
                        padding: EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: 0),
                        backgroundColor: THelperFunctions.getOrderStatusColor(
                                controller.orderStatus.value)
                            .withOpacity(0.1),
                        child: DropdownButton<OrderStatus>(
                          value: controller.orderStatus.value,
                          padding: EdgeInsets.symmetric(vertical: 0),
                          onChanged: (OrderStatus? value) {
                            if (value != null) {
                              controller.updateOrderStatus(order, value);
                            }
                          },
                          items: OrderStatus.values.map(
                            (OrderStatus status) {
                              return DropdownMenuItem<OrderStatus>(
                                value: status,
                                child: Text(
                                  status.name.capitalize.toString(),
                                  style: TextStyle(
                                      color: THelperFunctions.getOrderStatusColor(
                                          controller.orderStatus.value)),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      );
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total"),
                    Text(
                      '\$${order.totalAmount}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
