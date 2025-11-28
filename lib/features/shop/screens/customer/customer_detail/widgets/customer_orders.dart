import 'package:e_commerce_admin_pannel/common/widgets/loaders/animation_loader.dart';
import 'package:e_commerce_admin_pannel/common/widgets/loaders/loader_animation.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/customer/customer_detail_controller.dart';
import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../controllers/customer/customer_controller.dart';
import '../table/data_table.dart';

class CustomerOrders extends StatelessWidget{
  const CustomerOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    controller.getCustomerAddress();
    return  TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Obx(
        () {
          if(controller.orderLoading.value) return TLoaderAnimation();
          if(controller.allCustomerOrders.isEmpty){
            return TAnimationLoaderWidget(text: 'No Order Found', animation: TImages.pencilAnimation);
          }
          
          final totalAmount = controller.allCustomerOrders.fold(0.0, (previousValue, element) => previousValue + element.totalAmount,);
          return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Orders',style: Theme.of(context).textTheme.headlineMedium,),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Total Spent'),
                      TextSpan(text: '\$${totalAmount.toString()}',style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary),),
                      TextSpan(text: 'on ${controller.allCustomerOrders.length} Orders',style: Theme.of(context).textTheme.bodyLarge,),
                    ]
                  )
                )
              ],
            ),
            SizedBox(height: TSizes.spaceBtwItems,),
            TextFormField(
              controller: controller.searchTextController,
              onChanged: (value) =>controller.searchQuery(value),
              decoration: InputDecoration(hintText: 'Search Orders',prefixIcon: Icon(Iconsax.search_normal)),
            ),
            SizedBox(height: TSizes.spaceBtwSections,),
            CustomerOrderTable(),
          ],
        );
        },
      ),
    );
  }

}