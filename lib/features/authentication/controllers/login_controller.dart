import 'package:e_commerce_admin_pannel/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_admin_pannel/data/repositories/settings/settings_repository.dart';
import 'package:e_commerce_admin_pannel/data/repositories/user/user_repository.dart';
import 'package:e_commerce_admin_pannel/features/authentication/controllers/user_controller.dart';
import 'package:e_commerce_admin_pannel/features/authentication/models/user/user_model.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:e_commerce_admin_pannel/utils/constants/text_strings.dart';
import 'package:e_commerce_admin_pannel/utils/helpers/network_manager.dart';
import 'package:e_commerce_admin_pannel/utils/popups/full_screen_loader.dart';
import 'package:e_commerce_admin_pannel/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../personalization/controllers/user_controller.dart';
import '../../personalization/models/setting_model.dart';
import '../../personalization/models/user_model.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();

  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();


  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL')??'';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD')??'';
    super.onInit();
  }

  /// Handles email and password sign-in process
  Future<void> emailAndPasswordSignIn() async {

    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Registering Admin Account...', TImages.docerAnimation);

      // check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if(!formKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save Data if remember Me is selected
      if(rememberMe.value){
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Register user using Email & Password Authentication
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Create admin record in the FireStore
     final user = await UserController.instance.fetchUserDetails();

      // Remove Loader
      TFullScreenLoader.stopLoading();
     
     // If user is not admin , logout and return
      if(user.role != AppRole.admin){
        await AuthenticationRepository.instance.logout();
        TLoaders.errorSnackBar(title: 'Not Authorized',message: 'You are not authorized or do have access. Contact Admin');
      }else{
        // Redirect
        AuthenticationRepository.instance.screenRedirect();
      }

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap',message: e.toString());
    }
  }

  /// Handles registration of admin user
  Future<void> registerAdmin() async {

    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Registering Admin Account...', TImages.docerAnimation);

      // check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Register user using Email & Password Authentication
      await AuthenticationRepository.instance
          .registerWithEmailAndPassword(TTexts.adminEmail, TTexts.adminPassword);

      // Create admin record in the FireStore
      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(UserModel(
        id: AuthenticationRepository.instance.authUser!.uid,
        email: TTexts.adminEmail,
        firstName: 'Tejas',
        lastName: 'Sojitra',
        role: AppRole.admin,
        createdAt: DateTime.now(),
      ));

      // Create settings record in the FireStore
      final settingRepository = Get.put(SettingsRepository());
      settingRepository.registerSettings(SettingModel(
        appLogo: '',
        appName: 'My App',
        taxRate: 0.0,
        shippingCost: 0.0,
        freeShippingThreshold: 0.0,
      ));

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap',message: e.toString());
    }
  }
}
