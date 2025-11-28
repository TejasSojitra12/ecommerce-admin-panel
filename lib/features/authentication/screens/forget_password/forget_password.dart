import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/authentication/screens/forget_password/responsive_screens/forget_password_desktop_tablet.dart';
import 'package:e_commerce_admin_pannel/features/authentication/screens/forget_password/responsive_screens/forget_password_mobile.dart';
import 'package:flutter/cupertino.dart';

class ForgetPasswordScreen extends StatelessWidget{
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(useLayout: false,desktop:ForgetPasswordDesktopTablet() ,mobile: ForgetPasswordMobile(),);
  }

}