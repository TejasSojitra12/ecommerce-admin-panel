import 'package:e_commerce_admin_pannel/features/media/controllers/media_controller.dart';
import 'package:e_commerce_admin_pannel/features/media/models/image_model.dart';
import 'package:e_commerce_admin_pannel/utils/helpers/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../authentication/models/user/user_model.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  RxBool isLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();


  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      isLoading.value = true;
      final user = await userRepository.fetchAdminDetails();

      firstNameController.text = user.firstName;
      lastNameController.text = user.lastName;
      phoneNumberController.text = user.phoneNumber;
      emailController.text = user.email;


      this.user.value = user;
      isLoading.value = false;
      return user;
    } catch (e) {
      isLoading.value = false;
      TLoaders.errorSnackBar(
          title: 'Something went wrong.', message: e.toString());
      return UserModel.empty();
    }
  }

  void updateProfilePicture() async {
    try {
      isLoading.value = true;
      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages =
          await controller.selectImagesFromMedia();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        ImageModel selectedImage = selectedImages.first;
        print('image: ${selectedImage.url}');

        await userRepository
            .updateSingleField({'ProfilePicture': selectedImage.url});

        user.value.profilePicture = selectedImage.url;
        user.refresh();
        TLoaders.successSnackBar(
            title: 'Success', message: 'Profile Picture Updated');
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('error: $e');
      TLoaders.errorSnackBar(
          title: 'Something went wrong.', message: e.toString());
    }
  }

  void updateUserInfo() async {
    try {
      isLoading.value = true;

      // internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!formKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }

      user.value.firstName = firstNameController.text.trim();
      user.value.lastName = lastNameController.text.trim();
      user.value.phoneNumber = phoneNumberController.text.trim();
      print('data: ${user.value.toJson()}');
      await userRepository.updateUser(user.value);
      user.refresh();
     isLoading.value = false;

      TLoaders.successSnackBar(
          title: 'Success', message: 'User Information Updated');

    }catch (e) {
      isLoading.value = false;
      print('error: $e');
      TLoaders.errorSnackBar(
          title: 'Something went wrong.', message: e.toString());
    }
  }
}
