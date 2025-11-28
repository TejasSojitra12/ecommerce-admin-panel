

import 'package:e_commerce_admin_pannel/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_admin_pannel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';

class TRoutesMiddleware extends GetMiddleware{

  @override
  RouteSettings? redirect(String? route) {
    return AuthenticationRepository.instance.isAuthenticated ? null : const RouteSettings(name: TRoutes.login);
   }
}