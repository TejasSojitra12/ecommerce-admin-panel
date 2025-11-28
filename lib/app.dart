import 'package:e_commerce_admin_pannel/bindings/general_binding.dart';
import 'package:e_commerce_admin_pannel/routes/app_routes.dart';
import 'package:e_commerce_admin_pannel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils/constants/text_strings.dart';
import 'utils/device/web_material_scroll.dart';
import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      getPages: TAppRoutes.pages,
      initialRoute: TRoutes.login,
      unknownRoute: GetPage(
          name: '/page-not-found',
          page: () => const Scaffold(
                body: Center(
                  child: Text("Page Not Found!"),
                ),
              )),
      initialBinding: GeneralBinding(),
      scrollBehavior: MyCustomScrollBehavior(),
      // home: const FirstScreen(),
    );
  }
}



