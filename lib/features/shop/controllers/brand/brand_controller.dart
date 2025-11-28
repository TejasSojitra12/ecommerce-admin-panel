import 'package:e_commerce_admin_pannel/data/abstract/base_data_table_controller.dart';
import 'package:e_commerce_admin_pannel/data/repositories/brands/brand_repository.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/barnd_model.dart';
import 'package:get/get.dart';

import '../category/category_controller.dart';

class BrandController extends TBaseController<BrandModel> {
  static BrandController get instance => Get.find();

  final _brandRepository = Get.put(BrandRepository());
  final _categoryController = Get.put(CategoryController());

  @override
  bool containSearchQuery(item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(item) async {
    return await _brandRepository.deleteBrand(item);
  }

  @override
  Future<List<BrandModel>> fetchItems() async {
    // Fetch Brands
    final fetchBrands = await _brandRepository.getAllBrands();

    // Fetch Brand Categories Relational Data
    final fetchBrandCategories = await _brandRepository.getAllBrandCategories();

    // Fetch All Categories is data does not already exist
    if (_categoryController.allItems.isNotEmpty)
      await _categoryController.fetchItems();

    // Loop all brands and fetch categories of each
    for (var brand in fetchBrands) {
      // Extract CategoryIds from the documents
      List<String> categoryIds = fetchBrandCategories
          .where(
            (brandCategory) => brandCategory.brandId == brand.id,
          )
          .map(
            (brandCategory) => brandCategory.categoryId,
          )
          .toList();

      brand.brandCategories = _categoryController.allItems.where((category) => categoryIds.contains(category.id),).toList();

    }
    return fetchBrands;
  }

  void sortByName(int sortColumnIndex,  bool ascending){
    sortByProperty(sortColumnIndex, ascending, (BrandModel brand) => brand.name.toLowerCase(),);
  }
}
