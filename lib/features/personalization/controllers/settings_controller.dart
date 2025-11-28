import 'package:e_commerce_admin_pannel/features/media/controllers/media_controller.dart';
import 'package:e_commerce_admin_pannel/features/media/models/image_model.dart';
import 'package:e_commerce_admin_pannel/features/personalization/models/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/settings/settings_repository.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  RxBool isLoading = false.obs;
  Rx<SettingModel> setting = SettingModel().obs;

  final formKey = GlobalKey<FormState>();
  final appNameController = TextEditingController();
  final taxRateController = TextEditingController();
  final shippingCostController = TextEditingController();
  final freeShippingThresholdController = TextEditingController();

  final settingRepository = Get.put(SettingsRepository());

  @override
  void onInit() {
    fetchSettingsDetails();
    super.onInit();
  }

  Future<SettingModel> fetchSettingsDetails() async {
    try {
      isLoading.value = true;
      final setting = await settingRepository.fetchSettings();
      print(setting.toJson());
      this.setting.value = setting;

      appNameController.text = setting.appName;
      taxRateController.text = setting.taxRate.toString();
      shippingCostController.text = setting.shippingCost.toString();
      freeShippingThresholdController.text =
          setting.freeShippingThreshold == null
              ? ''
              : setting.freeShippingThreshold.toString();

      isLoading.value = false;
      return setting;
    } catch (e) {
      isLoading.value = false;
      TLoaders.errorSnackBar(
          title: 'Something went wrong.', message: e.toString());
      return SettingModel();
    }
  }

  /// Pick Thumbnail Image from Media
  void updateAppLogo() async {
    try {
      isLoading.value = true;
      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages =
          await controller.selectImagesFromMedia();

      if (selectedImages != null && selectedImages.isNotEmpty) {
        ImageModel selectedImage = selectedImages.first;

        await settingRepository.updateSettingField({
          'appLogo': selectedImage.url,
        });

        setting.value.appLogo = selectedImage.url;
        setting.refresh();

        TLoaders.successSnackBar(
            title: 'Success', message: 'App Logo Updated Successfully');
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      TLoaders.errorSnackBar(
          title: 'Something went wrong.', message: e.toString());
    }
  }

void updateSettingInformation()async{
    try{
      isLoading.value = true;

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if(!formKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }


      setting.value.appName = appNameController.text.trim();
      setting.value.taxRate = double.tryParse(taxRateController.text.trim()) ?? 0.0;
      setting.value.shippingCost = double.tryParse(shippingCostController.text.trim()) ?? 0.0;
      setting.value.freeShippingThreshold = double.tryParse(freeShippingThresholdController.text.trim()) ?? 0.0;

      await settingRepository.updateSettings(setting.value);
      setting.refresh();
      isLoading.value = false;
    }catch(e){
      isLoading.value = false;
      TLoaders.errorSnackBar(
          title: 'Oh Snap!', message: e.toString());
    }
}

}
