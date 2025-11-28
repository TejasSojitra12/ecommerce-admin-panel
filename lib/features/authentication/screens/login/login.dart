import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/authentication/screens/login/responsive_screens/login_desktop_tablet.dart';
import 'package:e_commerce_admin_pannel/features/authentication/screens/login/responsive_screens/login_mobile.dart';
import 'package:flutter/cupertino.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return const TSiteTemplate(useLayout: false,desktop: LoginScreenDesktopTablet(),mobile: LoginScreenMobile(),);
  }

}