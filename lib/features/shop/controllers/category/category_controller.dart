import 'package:e_commerce_admin_pannel/data/abstract/base_data_table_controller.dart';
import 'package:e_commerce_admin_pannel/data/repositories/category/category_repository.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:e_commerce_admin_pannel/utils/popups/full_screen_loader.dart';
import 'package:e_commerce_admin_pannel/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/category_model.dart';

class CategoryController extends TBaseController<CategoryModel> {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoryRepository());

  @override
  bool containSearchQuery(CategoryModel item, String query) {
   return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(CategoryModel item) async{
    await _categoryRepository.deleteCategory(item.id);
  }

  @override
  Future<List<CategoryModel>> fetchItems() async{
   return await _categoryRepository.getAllCategories();
  }

  void sortByName(int sortColumnIndex,  bool ascending){
    sortByProperty(sortColumnIndex, ascending, (CategoryModel category) => category.name.toLowerCase(),);
  }

  void sortByParentName(int sortColumnIndex,  bool ascending){
    sortByProperty(sortColumnIndex, ascending, (CategoryModel category) => category.name.toLowerCase(),);
  }
}
