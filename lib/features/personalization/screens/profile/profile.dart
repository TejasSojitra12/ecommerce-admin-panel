import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/personalization/screens/profile/responsive_screens/profile_desktop_screen.dart';
import 'package:e_commerce_admin_pannel/features/personalization/screens/profile/responsive_screens/profile_mobile_screen.dart';
import 'package:e_commerce_admin_pannel/features/personalization/screens/profile/responsive_screens/profile_tablet_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return TSiteTemplate(
     desktop: ProfileDesktopScreen(),
     tablet:  ProfileTabletScreen(),
     mobile: ProfileMobileScreen(),
   );
  }

}