import 'package:e_commerce_admin_pannel/data/abstract/base_data_table_controller.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/banner/banner_repository.dart';
import '../../models/banner_model.dart';
import '../category/category_controller.dart';

class BannerController extends TBaseController<BannerModel> {
  static BannerController get instance => Get.find();

  final _bannerRepository = Get.put(BannerRepository());

  @override
  bool containSearchQuery(item, String query) {
    return false;
  }

  @override
  Future<void> deleteItem(item) async {
    return await _bannerRepository.deleteBanner(item.id ?? '');
  }

  @override
  Future<List<BannerModel>> fetchItems() async {
   return await _bannerRepository.getAllBanner();
  }

  /// Method for formating Route Screen
  String formatRoute(String route){
    if(route.isEmpty) return '';

    // Remove the leading '/'
    String formattedRoute = route.substring(1);

    // Capitalize the first character
    formattedRoute = formattedRoute[0].toUpperCase() + formattedRoute.substring(1);

    return formattedRoute;
  }


}
