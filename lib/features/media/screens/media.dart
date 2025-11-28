
import 'package:e_commerce_admin_pannel/common/widgets/layout/templets/site_layout.dart';
import 'package:e_commerce_admin_pannel/features/media/screens/responsive_screens/media_desktop.dart';
import 'package:flutter/material.dart';

class MediaScreen extends StatelessWidget{
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return const TSiteTemplate(desktop: MediaDesktopScreen(),);
  }

}