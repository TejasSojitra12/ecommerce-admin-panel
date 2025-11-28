import 'package:e_commerce_admin_pannel/features/authentication/screens/forget_password/widgets/forget_form.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';

class ForgetPasswordMobile extends StatelessWidget {
  const ForgetPasswordMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(TSizes.defaultSpace),
          child: HeaderAndForm()),
    );
  }
}
