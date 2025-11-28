import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/loaders/loader_animation.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/address_model.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/customer/customer_detail_controller.dart';

class ShippingAddress extends StatelessWidget{
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    controller.getCustomerAddress();
    return Obx(
      () {
        if(controller.addressLoading.value)return TLoaderAnimation();

        AddressModel selectedAddress = AddressModel.empty();
        if(controller.customer.value.addresses != null){
          if(controller.customer.value.addresses!.isNotEmpty){
            selectedAddress = controller.customer.value.addresses!.firstWhere((element) => element.selectedAddress);
          }
        }
        return TRoundedContainer(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shipping Address',style: Theme.of(context).textTheme.headlineMedium,),
            SizedBox(height: TSizes.spaceBtwSections,),

            // Meta Data
            Row(
              children: [
                SizedBox(width: 120,child: Text('Name'),),
                Text(':'),
                SizedBox(width: TSizes.spaceBtwItems/2,),
                Expanded(child: Text(selectedAddress.name,style: Theme.of(context).textTheme.titleMedium,)),
              ],
            ),
            SizedBox(height: TSizes.spaceBtwItems,),
            Row(
              children: [
                SizedBox(width: 120,child: Text('Country'),),
                Text(':'),
                SizedBox(width: TSizes.spaceBtwItems/2,),
                Expanded(child: Text(selectedAddress.country,style: Theme.of(context).textTheme.titleMedium,)),
              ],
            ),
            SizedBox(height: TSizes.spaceBtwItems,),
            Row(
              children: [
                SizedBox(width: 120,child: Text('Phone Number'),),
                Text(':'),
                SizedBox(width: TSizes.spaceBtwItems/2,),
                Expanded(child: Text(selectedAddress.formatedPhoneNo,style: Theme.of(context).textTheme.titleMedium,)),
              ],
            ),
            SizedBox(height: TSizes.spaceBtwItems,),
            Row(
              children: [
                SizedBox(width: 120,child: Text('Address'),),
                Text(':'),
                SizedBox(width: TSizes.spaceBtwItems/2,),
                Expanded(child: Text(selectedAddress.id.isNotEmpty ? selectedAddress.toString() : 'No Address',style: Theme.of(context).textTheme.titleMedium,)),
              ],
            ),
          ],
        ),
      );
      },
    );
  }

}