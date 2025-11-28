import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

class LoginScreenMobile extends StatelessWidget{
  const LoginScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: TColors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            // Header
            TLoginHeader(),
            // form
            TLoginForm(),
          ],
        ),
      ),
    );
  }

}