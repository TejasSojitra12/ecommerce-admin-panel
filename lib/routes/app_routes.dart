
import 'package:e_commerce_admin_pannel/features/authentication/screens/forget_password/forget_password.dart';
import 'package:e_commerce_admin_pannel/features/authentication/screens/reset_password/reset_password.dart';
import 'package:e_commerce_admin_pannel/features/media/screens/media.dart';
import 'package:e_commerce_admin_pannel/features/personalization/screens/profile/profile.dart';
import 'package:e_commerce_admin_pannel/features/personalization/screens/settings/settings.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/banner/all_banners/banners.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/banner/create_banner/create_banner.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/banner/edit_banner/edit_banner.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/brand/all_brand/brands.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/brand/create_brand/create_brand.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/brand/edit_brand/edit_brand.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/category/all_categories/categories.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/category/create_category/create_category.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/category/edit_category/edit_category.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/customer/all_customer/customers.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/customer/customer_detail/customers_detail.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/order/all_orders/orders.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/product/all_products/product.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/product/create_product/create_product.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/product/edit_product/edit_product.dart';
import 'package:e_commerce_admin_pannel/routes/routes.dart';
import 'package:e_commerce_admin_pannel/routes/routes_middleware.dart';
import 'package:get/get.dart';

import '../features/authentication/screens/login/login.dart';
import '../features/shop/screens/dashboard/dashboard_screen.dart';
import '../features/shop/screens/order/orders_detail/order_detail.dart';


class TAppRoutes{
  static final List<GetPage> pages = [
    GetPage(name: TRoutes.login, page: ()=>const LoginScreen()),
    GetPage(name: TRoutes.forgetPassword, page: ()=>const ForgetPasswordScreen()),
    GetPage(name: TRoutes.resetPassword, page: ()=>const ResetPasswordScreen()),
    GetPage(name: TRoutes.dashboard, page: ()=>const DashboardScreen(),middlewares: [TRoutesMiddleware()]),
    GetPage(name: TRoutes.media, page: ()=>const MediaScreen(),middlewares: [TRoutesMiddleware()]),

    GetPage(name: TRoutes.categories, page: ()=> const CategoriesScreen(),middlewares: [TRoutesMiddleware()]),
    GetPage(name: TRoutes.createCategory, page: ()=> const CreateCategoryScreen(),middlewares: [TRoutesMiddleware()]),
    GetPage(name: TRoutes.editCategory, page: ()=> const EditCategoryScreen(),middlewares: [TRoutesMiddleware()]),

    GetPage(name: TRoutes.brands, page: ()=> const BrandScreen(),middlewares: [TRoutesMiddleware()]),
    GetPage(name: TRoutes.createBrand, page: ()=> const CreateBrandScreen(),middlewares: [TRoutesMiddleware()]),
    GetPage(name: TRoutes.editBrand, page: ()=> const EditBrandScreen(),middlewares: [TRoutesMiddleware()]),

    GetPage(name: TRoutes.banners, page: ()=> const BannerScreen(),middlewares: [TRoutesMiddleware()]),
    GetPage(name: TRoutes.createBanner, page: ()=> const CreateBannerScreen(),middlewares: [TRoutesMiddleware()]),
    GetPage(name: TRoutes.editBanner, page: ()=> const EditBannerScreen(),middlewares: [TRoutesMiddleware()]),

    GetPage(name: TRoutes.products, page: ()=> const ProductScreen(),middlewares: [TRoutesMiddleware()]),
    GetPage(name: TRoutes.createProduct, page: ()=> const CreateProductScreen(),middlewares: [TRoutesMiddleware()]),
    GetPage(name: TRoutes.editProduct, page: ()=> const EditProductScreen(),middlewares: [TRoutesMiddleware()]),

    GetPage(name: TRoutes.customers, page: ()=> const CustomerScreen(),middlewares: [TRoutesMiddleware()]),
    GetPage(name: TRoutes.customerDetails, page: ()=> const CustomerDetailScreen(),middlewares: [TRoutesMiddleware()]),

    GetPage(name: TRoutes.orders, page: ()=> const OrderScreen(),middlewares: [TRoutesMiddleware()]),
    GetPage(name: TRoutes.ordersDetails, page: ()=> const OrderDetailScreen(),middlewares: [TRoutesMiddleware()]),

    GetPage(name: TRoutes.profile, page: ()=> const ProfileScreen(),middlewares: [TRoutesMiddleware()]),
    GetPage(name: TRoutes.settings, page: ()=> const SettingsScreen(),middlewares: [TRoutesMiddleware()]),


  ];
}