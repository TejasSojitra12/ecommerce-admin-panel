import 'package:e_commerce_admin_pannel/common/widgets/layout/headers/header.dart';
import 'package:e_commerce_admin_pannel/common/widgets/layout/sidebars/sidebar.dart';
import 'package:flutter/material.dart';

class TabletLayout extends StatelessWidget {
   TabletLayout({super.key, this.body});

  final Widget? body;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const TSideBar(),
      appBar: THeader(scaffoldKey: scaffoldKey,),
      body: body ?? const SizedBox(),
    );
  }
}
