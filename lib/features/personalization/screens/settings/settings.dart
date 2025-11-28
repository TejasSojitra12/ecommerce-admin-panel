import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/personalization/screens/settings/responsive_screens/settings_desktop_screen.dart';
import 'package:e_commerce_admin_pannel/features/personalization/screens/settings/responsive_screens/settings_mobile_screen.dart';
import 'package:e_commerce_admin_pannel/features/personalization/screens/settings/responsive_screens/settings_tablet_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: SettingsDesktopScreen(),
      tablet: SettingsTabletScreen(),
      mobile: SettingsMobileScreen(),
    );
  }
}
