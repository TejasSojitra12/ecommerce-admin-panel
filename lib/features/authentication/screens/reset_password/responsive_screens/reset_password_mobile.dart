import 'package:e_commerce_admin_pannel/features/authentication/screens/reset_password/widgets/reset_password_widget.dart';
import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ResetPasswordMobile extends StatelessWidget{
  const ResetPasswordMobile({super.key});
  @override
  Widget build(BuildContext context){
    return const Scaffold(
      backgroundColor: TColors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: ResetPasswordWidget(),
      ),
    );
  }
}