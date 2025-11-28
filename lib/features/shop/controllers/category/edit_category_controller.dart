import 'package:e_commerce_admin_pannel/data/repositories/category/category_repository.dart';
import 'package:e_commerce_admin_pannel/features/media/controllers/media_controller.dart';
import 'package:e_commerce_admin_pannel/features/media/models/image_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/category/category_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/category_model.dart';
import 'package:e_commerce_admin_pannel/utils/helpers/network_manager.dart';
import 'package:e_commerce_admin_pannel/utils/popups/full_screen_loader.dart';
import 'package:e_commerce_admin_pannel/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditCategoryController extends GetxController {
  static EditCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  /// Init
  void init(CategoryModel category){
    name.text = category.name;
    isFeatured.value = category.isFeatured;
    imageURL.value = category.image;
    if(category.parentId.isNotEmpty){
      selectedParent.value = CategoryController.instance.allItems.where((c) => c.id == category.parentId,).single;
    }
  }

  /// Method to reset fields
  void resetFields() {
    selectedParent(CategoryModel.empty());
    loading(false);
    isFeatured(false);
    name.clear();
    imageURL.value = '';
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

  /// Update Category
  Future<void> updateCategory(CategoryModel category) async {
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
      category.name = name.text.trim();
      category.image = imageURL.value;
      category.parentId = selectedParent.value.id;
      category.isFeatured = isFeatured.value;
      category.updatedAt = DateTime.now();

      // Call repository
      await CategoryRepository.instance.updateCategory(category);

      // Update record list
      CategoryController.instance.updateItemFromList(category);

      // Reset Form
      resetFields();

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


}
