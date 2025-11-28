import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/order_model.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:e_commerce_admin_pannel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTransaction extends StatelessWidget {
  const OrderTransaction({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transactions',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          // Adjust as per your needs
          Row(
            children: [
              Expanded(
                flex: TDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Row(
                  children: [
                    TRoundedImage(
                      imageType: ImageType.asset,
                      image: TImages.paypal,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment via ${order.paymentMethod.capitalize}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        // Adjust of your payment method fee is any
                        Text(
                          '${order.paymentMethod.capitalize} fee \$25',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ))
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date',style: Theme.of(context).textTheme.labelMedium,),
                  Text('April 21, 2025',style: Theme.of(context).textTheme.bodyLarge,),
                ],
              )),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total',style: Theme.of(context).textTheme.labelMedium,),
                      Text('\$${order.totalAmount}',style: Theme.of(context).textTheme.bodyLarge,),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
