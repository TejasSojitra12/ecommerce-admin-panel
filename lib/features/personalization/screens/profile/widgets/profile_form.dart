import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:e_commerce_admin_pannel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    controller.firstNameController.text = controller.user.value.firstName;
    controller.lastNameController.text = controller.user.value.lastName;
    controller.phoneNumberController.text = controller.user.value.phoneNumber;
    controller.emailController.text = controller.user.value.email;
    return Column(
      children: [
        TRoundedContainer(
          padding:
              EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile Details',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // First And Last Name
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        // First Name
                        Expanded(
                            child: TextFormField(
                          controller: controller.firstNameController,
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            label: Text('First Name'),
                            prefixIcon: Icon(Iconsax.user),
                          ),
                          validator: (value) =>
                              TValidator.validateEmptyText('First Name', value),
                        )),
                        SizedBox(
                          width: TSizes.spaceBtwInputFields,
                        ),
                        // Last Name
                        Expanded(
                            child: TextFormField(
                          controller: controller.lastNameController,
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            label: Text('Last Name'),
                            prefixIcon: Icon(Iconsax.user),
                          ),
                          validator: (value) =>
                              TValidator.validateEmptyText('Last Name', value),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),

                    // Email and Phone
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                              controller: controller.emailController,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            label: Text('Email'),
                            prefixIcon: Icon(Iconsax.forward),
                          ),
                          validator: (value) => TValidator.validateEmail(value),
                        )),
                        SizedBox(
                          width: TSizes.spaceBtwInputFields,
                        ),
                        // Last Name
                        Expanded(
                            child: TextFormField(
                          controller: controller.phoneNumberController,
                          // enabled: false,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            label: Text('Phone Number'),
                            prefixIcon: Icon(Iconsax.mobile),
                          ),
                          validator: (value) =>
                              TValidator.validatePhoneNumber(value),
                        ))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              SizedBox(
                width: double.infinity,
                child: Obx(() => ElevatedButton(
                    onPressed:  controller.isLoading.value
                        ? () {}
                        : ()=>controller.updateUserInfo(),
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                        : Text('Update Profile'))),
              )
            ],
          ),
        )
      ],
    );
  }
}
