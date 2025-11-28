import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_admin_pannel/features/authentication/models/user/user_model.dart';
import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../personalization/models/user_model.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({super.key, required this.customer});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Information',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          // Personal Info Card
          Row(
            children: [
              TRoundedImage(
                padding: 0,
                backgroundColor: TColors.primaryBackground,
                image: customer.profilePicture.isNotEmpty ? customer.profilePicture : TImages.user,
                imageType: customer.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
              ),
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(customer.fullName,style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,),
                  Text(customer.email,overflow: TextOverflow.ellipsis,maxLines: 1,),
                ],
              ))
            ],
          ),
          SizedBox(height: TSizes.spaceBtwSections),

          // Meta Data
          Row(
            children: [
              SizedBox(width: 120,child: Text('Username'),),
              Text(':'),
              SizedBox(width: TSizes.spaceBtwItems/2,),
              Expanded(child: Text(customer.userName,style: Theme.of(context).textTheme.titleMedium,)),
            ],
          ),
          SizedBox(height: TSizes.spaceBtwItems,),
          Row(
            children: [
              SizedBox(width: 120,child: Text('Country'),),
              Text(':'),
              SizedBox(width: TSizes.spaceBtwItems/2,),
              Expanded(child: Text('India',style: Theme.of(context).textTheme.titleMedium,)),
            ],
          ),
          SizedBox(height: TSizes.spaceBtwItems,),
          Row(
            children: [
              SizedBox(width: 120,child: Text('Phone Number'),),
              Text(':'),
              SizedBox(width: TSizes.spaceBtwItems/2,),
              Expanded(child: Text(customer.formatedPhoneNo,style: Theme.of(context).textTheme.titleMedium,)),
            ],
          ),
          SizedBox(height: TSizes.spaceBtwItems,),

          Divider(),
          SizedBox(height: TSizes.spaceBtwItems,),

          // Additional Info
          Row(
            children: [
              Expanded(child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Last Order',style: Theme.of(context).textTheme.titleLarge,),
                  Text('7 Days Ago, #[36d54]')
                ],
              )),
              Expanded(child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Average Order Value',style: Theme.of(context).textTheme.titleLarge,),
                  Text('\$352')
                ],
              ))
            ],
          ),
          SizedBox(height: TSizes.spaceBtwItems,),
          Row(
            children: [
              Expanded(child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Registered',style: Theme.of(context).textTheme.titleLarge,),
                  Text(customer.formattedDate)
                ],
              )),
              Expanded(child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email Marketing',style: Theme.of(context).textTheme.titleLarge,),
                  Text('Subscribed')
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }
}
