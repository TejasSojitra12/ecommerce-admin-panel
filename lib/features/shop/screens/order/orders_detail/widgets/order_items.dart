import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/order_model.dart';
import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:e_commerce_admin_pannel/utils/device/device_utility.dart';
import 'package:e_commerce_admin_pannel/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final subTotal = order.items.fold(
      0.0,
      (previousValue, element) =>
          previousValue + (element.price * element.quantity),
    );
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Items',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          // Items
          ListView.separated(
            shrinkWrap: true,
            itemCount: order.items.length,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            itemBuilder: (context, index) {
              final item = order.items[index];
              return Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        TRoundedImage(
                            backgroundColor: TColors.primaryBackground,
                            image: item.image ?? TImages.defaultImage,
                            imageType: item.image != null
                                ? ImageType.network
                                : ImageType.asset),
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                item.title,
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              if (item.selectVariation != null)
                                Text(item.selectVariation!.entries
                                    .map(
                                      (e) => ('${e.key} : ${e.value} '),
                                    )
                                    .toString())
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems,),
                  SizedBox(
                    width: TSizes.xl *2,
                    child: Text('\$${item.price.toStringAsFixed(1)}',style: Theme.of(context).textTheme.bodyLarge,),

                  ),
                  SizedBox(
                    width: TDeviceUtils.isMobileScreen(context) ? TSizes.xl *1.4 : TSizes.xl*2,
                    child: Text('\$${item.quantity.toString()}',style: Theme.of(context).textTheme.bodyLarge,),

                  ),
                  SizedBox(
                    width: TDeviceUtils.isMobileScreen(context) ? TSizes.xl *1.4 : TSizes.xl*2,

                    child: Text('\$${item.totalAmount}',style: Theme.of(context).textTheme.bodyLarge,),

                  )
                ],
              );
            },
          ),
          SizedBox(height: TSizes.spaceBtwSections,),

          // Items Total
          TRoundedContainer(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            backgroundColor: TColors.primaryBackground,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal',style: Theme.of(context).textTheme.titleLarge,),
                    Text('\$$subTotal',style: Theme.of(context).textTheme.titleLarge,),
                  ],
                ),
                SizedBox(height: TSizes.spaceBtwItems,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discount',style: Theme.of(context).textTheme.titleLarge,),
                    Text('\$0.0',style: Theme.of(context).textTheme.titleLarge,),
                  ],
                ),
                SizedBox(height: TSizes.spaceBtwItems,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Shipping',style: Theme.of(context).textTheme.titleLarge,),
                    Text('\$${TPricingCalculator.calculateShippingCost(subTotal, '')}',style: Theme.of(context).textTheme.titleLarge,),
                  ],
                ),
                SizedBox(height: TSizes.spaceBtwItems,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tax',style: Theme.of(context).textTheme.titleLarge,),
                    Text('\$${TPricingCalculator.calculateTax(subTotal, '')}',style: Theme.of(context).textTheme.titleLarge,),

                  ],
                ),
                SizedBox(height: TSizes.spaceBtwItems,),
                Divider(),
                SizedBox(height: TSizes.spaceBtwItems,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total',style: Theme.of(context).textTheme.titleLarge,),
                    Text('\$${TPricingCalculator.calculateTotalPrice(subTotal, '')}',style: Theme.of(context).textTheme.titleLarge,),

                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
