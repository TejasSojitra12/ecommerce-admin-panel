import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/order/order_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/order/order_detail_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/order_model.dart';
import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCustomerInfo extends StatelessWidget{
  const OrderCustomerInfo({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());
    controller.order.value = order;
    controller.getCustomerOfCurrentOrder();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personal Info
        TRoundedContainer(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Customer',style:Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: TSizes.spaceBtwSections,),
              Obx(
                () {
                  return Row(
                  children: [
                    TRoundedImage(
                      padding: 0,
                      backgroundColor: TColors.primaryBackground,
                      imageType: controller.customer.value.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
                      image: controller.customer.value.profilePicture.isNotEmpty ? controller.customer.value.profilePicture : TImages.user,
                    ),
                    SizedBox(width: TSizes.spaceBtwItems,),
                    Expanded(child:
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.customer.value.fullName,style: Theme.of(context).textTheme.titleLarge,overflow: TextOverflow.ellipsis,maxLines: 1,),
                        Text(controller.customer.value.email,overflow: TextOverflow.ellipsis,maxLines: 1,),


                      ],
                    ))
                  ],
                );
                },
              )
            ],
          ),
        ),
        SizedBox(height: TSizes.spaceBtwSections,),

        // Contact Info
        SizedBox(
          width: double.infinity,
          child: TRoundedContainer(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Contact Person',style: Theme.of(context).textTheme.headlineMedium,),
                SizedBox(height: TSizes.spaceBtwSections,),
                Text(controller.customer.value.fullName,style: Theme.of(context).textTheme.titleSmall,),
                SizedBox(height: TSizes.spaceBtwSections/2,),
                Text(controller.customer.value.email,style: Theme.of(context).textTheme.titleSmall,),
                SizedBox(height: TSizes.spaceBtwSections/2,),
                Text(controller.customer.value.formatedPhoneNo.isNotEmpty ? controller.customer.value.formatedPhoneNo : 'N/A',style: Theme.of(context).textTheme.titleSmall,),
              ],
            ),
          ),
        ),
        SizedBox(height: TSizes.spaceBtwSections,),

        // Shipping address details
        SizedBox(
          width: double.infinity,
          child: TRoundedContainer(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shipping Address',style: Theme.of(context).textTheme.headlineMedium,),
                SizedBox(height: TSizes.spaceBtwSections,),
                Text(order.shippingAddress != null ? order.shippingAddress!.name : 'N/A',style: Theme.of(context).textTheme.titleSmall,),
                SizedBox(height: TSizes.spaceBtwItems/2,),
                Text(order.shippingAddress != null ? order.shippingAddress!.toString() : 'N/A' ,style: Theme.of(context).textTheme.titleSmall,),


              ],
            ),
          ),
        ),
        SizedBox(height: TSizes.spaceBtwSections,),

        // Billing address details
        SizedBox(
          width: double.infinity,
          child: TRoundedContainer(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Billing Address',style: Theme.of(context).textTheme.headlineMedium,),
                SizedBox(height: TSizes.spaceBtwSections,),
                Text(order.billingAddress != null ? order.billingAddress!.name : 'N/A',style: Theme.of(context).textTheme.titleSmall,),
                SizedBox(height: TSizes.spaceBtwItems/2,),
                Text(order.billingAddress != null ? order.billingAddress!.toString() : 'N/A' ,style: Theme.of(context).textTheme.titleSmall,),


              ],
            ),
          ),
        ),
        SizedBox(height: TSizes.spaceBtwSections,),
      ],
    );
  }

}