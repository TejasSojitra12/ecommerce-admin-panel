import 'package:e_commerce_admin_pannel/common/widgets/layout/headers/header.dart';
import 'package:e_commerce_admin_pannel/common/widgets/layout/sidebars/sidebar.dart';
import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
   const DesktopLayout({super.key, this.body});

  final Widget? body;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
           const Expanded(child: TSideBar()),
          Expanded(
            flex: 5 ,
            child: Column(
              children: [
                /// Header
               const THeader(),

                /// body
                Expanded(child: body ?? const SizedBox()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
