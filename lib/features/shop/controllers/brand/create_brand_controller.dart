import 'package:e_commerce_admin_pannel/data/repositories/brands/brand_repository.dart';
import 'package:e_commerce_admin_pannel/data/repositories/category/category_repository.dart';
import 'package:e_commerce_admin_pannel/features/media/controllers/media_controller.dart';
import 'package:e_commerce_admin_pannel/features/media/models/image_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/category/category_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/barnd_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/brand_category.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/category_model.dart';
import 'package:e_commerce_admin_pannel/utils/helpers/network_manager.dart';
import 'package:e_commerce_admin_pannel/utils/popups/full_screen_loader.dart';
import 'package:e_commerce_admin_pannel/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'brand_controller.dart';

class CreateBrandController extends GetxController {
  static CreateBrandController get instance => Get.find();

  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  /// Toggle Category Selection
  void toggleSelection(CategoryModel category){
    if(selectedCategories.contains(category)){
      selectedCategories.remove(category);
    }else{
      selectedCategories.add(category);
    }
  }

  /// Method to reset fields
  void resetFields() {
    name.clear();
    loading(false);
    isFeatured(false);
    imageURL.value = '';
    selectedCategories.clear();
  }

  /// Pick Thumbnail Image From Media
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      imageURL.value = selectedImage.url;
    }
  }

  /// Register new Brand
  Future<void> createBrand() async {
    try {
      // Start Loading
      TFullScreenLoader.popUpCircular();

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Map Data
      final newRecord = BrandModel(
          id: '',
          productsCount: 0,
          name: name.text.trim(),
          image: imageURL.value,
          isFeatured: isFeatured.value,
          createdAt: DateTime.now()
      );

      newRecord.id = await BrandRepository.instance.createBrand(newRecord);

      if(selectedCategories.isNotEmpty){
        if(newRecord.id.isEmpty) throw 'Error storing relational data. Try again';
        
        // Loop selected Brand Categories
        for(var category in selectedCategories){
          // Map Data
          final brandCategory = BrandCategoryModel(brandId: newRecord.id, categoryId: category.id);
          await BrandRepository.instance.createBrandCategory(brandCategory);
        }

        newRecord.brandCategories ??= [];
        newRecord.brandCategories!.addAll(selectedCategories);
      }

      // Update All Data List
      BrandController.instance.addItemToLists(newRecord);

      // Reset Form
      resetFields();

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Success Message & Redirect
      Get.back();
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'New Record has been added.');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }


}
