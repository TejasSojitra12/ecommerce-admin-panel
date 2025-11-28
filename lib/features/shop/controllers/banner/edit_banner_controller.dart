
import 'package:e_commerce_admin_pannel/data/repositories/banner/banner_repository.dart';
import 'package:e_commerce_admin_pannel/features/media/controllers/media_controller.dart';
import 'package:e_commerce_admin_pannel/features/media/models/image_model.dart';
import 'package:e_commerce_admin_pannel/utils/helpers/network_manager.dart';
import 'package:e_commerce_admin_pannel/utils/popups/full_screen_loader.dart';
import 'package:e_commerce_admin_pannel/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../routes/app_screens.dart';
import '../../models/banner_model.dart';
import 'banner_controller.dart';

class EditBannerController extends GetxController {
  static EditBannerController get instance => Get.find();

  RxString imageURL = ''.obs;
  final loading = false.obs;
  final isActive = false.obs;
  final RxString targetScreen = ''.obs;
  final formKey = GlobalKey<FormState>();
  final repository = Get.put(BannerRepository());

  /// Init
  void init(BannerModel banner){
    imageURL.value = banner.imageUrl;
    isActive.value = banner.active;
    targetScreen.value = banner.targetScreen;
  }


  /// Method to reset fields
  void resetFields() {
    loading(false);
    isActive(false);
    imageURL.value = '';
    targetScreen.value = AppScreens.allAppScreenItems[0];
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

  /// Update Banner
  Future<void> updateBanner(BannerModel banner) async {
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

      bool isBannerUpdated = false;
      if(banner.imageUrl != imageURL.value || banner.targetScreen != targetScreen.value || banner.active != isActive.value){
        isBannerUpdated = true;

        // Map Data
        // Map Data
        banner.imageUrl = imageURL.value;
        banner.active = isActive.value;
        banner.targetScreen = targetScreen.value;

        // Call Repository to Update
        await repository.updateBanner(banner);
      }



      // Update All Data List
      BannerController.instance.updateItemFromList(banner);


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


