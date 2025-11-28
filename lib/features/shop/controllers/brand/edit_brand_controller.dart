import 'package:e_commerce_admin_pannel/data/repositories/brands/brand_repository.dart';
import 'package:e_commerce_admin_pannel/data/repositories/category/category_repository.dart';
import 'package:e_commerce_admin_pannel/features/media/controllers/media_controller.dart';
import 'package:e_commerce_admin_pannel/features/media/models/image_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/category/category_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/barnd_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/category_model.dart';
import 'package:e_commerce_admin_pannel/utils/helpers/network_manager.dart';
import 'package:e_commerce_admin_pannel/utils/popups/full_screen_loader.dart';
import 'package:e_commerce_admin_pannel/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/brand_category.dart';
import 'brand_controller.dart';

class EditBrandController extends GetxController {
  static EditBrandController get instance => Get.find();

  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final repository = Get.put(BrandRepository());
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;



  /// Init
  void init(BrandModel brand){
    name.text = brand.name;
    imageURL.value = brand.image;
    isFeatured.value = brand.isFeatured;
    if(brand.brandCategories != null ){
      selectedCategories.addAll(brand.brandCategories ?? []);
  }
  }

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

  /// Update Brand
  Future<void> updateBrand(BrandModel brand) async {
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

     bool isBrandUpdated = false;
      if(brand.image != imageURL.value || brand.name != name.text.trim() || brand.isFeatured != isFeatured.value){
        isBrandUpdated = true;

        // Map Data
        // Map Data
        brand.name = name.text.trim();
        brand.image = imageURL.value;
        brand.isFeatured = isFeatured.value;
        brand.updatedAt = DateTime.now();

        // Call Repository to Update
        await repository.updateBrand(brand);
      }

      // Update Brand Categories
      if(selectedCategories.isNotEmpty) await updateBrandCategories(brand);

      // Update Brand Data in Products
      if(isBrandUpdated) await updateBrandInProducts(brand);

      // Update All Data List
      BrandController.instance.updateItemFromList(brand);

      // Update UI Listeners
      update();


      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Success Message & Redirect
      Get.back();
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'Record has been Updated Successfully.');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Update Categories of this Brand
  updateBrandCategories(BrandModel brand) async {
    // Fetch all BrandCategories
    final brandCategories = await repository.getCategoriesOfSpecificBrand(brand.id);

    // SelectedCategoryIds
    final selectedCategoryIds = selectedCategories.map((e) => e.id).toList();
    // Identify Categories to remove
    final categoriesToRemove = brandCategories.where((brandCategory) => !selectedCategoryIds.contains(brandCategory.categoryId),).toList();

    // Remove Unselected Categories
    for(var category in categoriesToRemove){
      await BrandRepository.instance.deleteBrandCategory(category.id ?? '');
    }

    // Identify new categories to add
    final newCategoriesToAdd = selectedCategories.where((category) => !brandCategories.any((brandCategory) => brandCategory.categoryId == category.id),).toList();
    // Add New Categories
    for(var category in newCategoriesToAdd) {
      final brandCategory = BrandCategoryModel(
          brandId: brand.id, categoryId: category.id);
      brandCategory.id =
      await BrandRepository.instance.createBrandCategory(brandCategory);
    }

    brand.brandCategories!.assignAll(selectedCategories);
    BrandController.instance.updateItemFromList(brand);

  }

  updateBrandInProducts(BrandModel brand) async {}

}


