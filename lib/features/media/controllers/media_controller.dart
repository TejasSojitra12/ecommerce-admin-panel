import 'dart:typed_data';

import 'package:e_commerce_admin_pannel/common/widgets/loaders/circular_loader.dart';
import 'package:e_commerce_admin_pannel/data/repositories/media/media_repository.dart';
import 'package:e_commerce_admin_pannel/features/media/screens/widgets/media_content.dart';
import 'package:e_commerce_admin_pannel/features/media/screens/widgets/media_uploader.dart';
import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:e_commerce_admin_pannel/utils/constants/text_strings.dart';
import 'package:e_commerce_admin_pannel/utils/popups/dialogs.dart';
import 'package:e_commerce_admin_pannel/utils/popups/full_screen_loader.dart';
import 'package:e_commerce_admin_pannel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_admin_pannel/features/media/models/image_model.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  final RxBool loading = false.obs;

  final int initialLoadCount = 20;
  final int loadMoreCount = 25;

  late DropzoneViewController dropzoneViewController;
  final RxBool showImageUploaderSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;
  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;

  final RxList<ImageModel> allImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBannerImages = <ImageModel>[].obs;
  final RxList<ImageModel> allProductImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBrandImages = <ImageModel>[].obs;
  final RxList<ImageModel> allCategoryImages = <ImageModel>[].obs;
  final RxList<ImageModel> allUserImages = <ImageModel>[].obs;

  final MediaRepository mediaRepository = MediaRepository();

  // Get Images
  void getMediaImages() async {
    try {
      loading.value = true;

      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if (selectedPath.value == MediaCategory.banners &&
          allBannerImages.isEmpty) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands &&
          allBrandImages.isEmpty) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories &&
          allCategoryImages.isEmpty) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products &&
          allProductImages.isEmpty) {
        targetList = allProductImages;
      } else
      if (selectedPath.value == MediaCategory.users && allUserImages.isEmpty) {
        targetList = allUserImages;
      }

      final images = await mediaRepository.fetchImagesFromDatabase(
          selectedPath.value, initialLoadCount);
      targetList.assignAll(images);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snap',
          message: 'Unable to fetch Images, Something went wrong. Try again');
    }
  }

  void loadMoreMediaImages() async {
    try {
      loading.value = true;

      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if (selectedPath.value == MediaCategory.banners) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.users) {
        targetList = allUserImages;
      }

      final images = await mediaRepository.loadMoreImagesFromDatabase(
          selectedPath.value, loadMoreCount,targetList.last.createdAt ?? DateTime.now());
      targetList.addAll(images);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLoaders.warningSnackBar(title: 'Oh Snap',
          message: 'Unable to fetch Images, Something went wrong. Try again');
    }
  }


  Future<void> selectLocalImages() async {
    final files = await dropzoneViewController
        .pickFiles(multiple: true, mime: ['image/jpeg', 'image/png']);

    if (files.isNotEmpty) {
      for (var file in files) {
        // if(file is html.File){
        final bytes = await dropzoneViewController.getFileData(file);
        final image = ImageModel(
          url: '',
          file: file,
          folder: '',
          filename: file.name,
          localImageToDisplay: Uint8List.fromList(bytes),
        );
        selectedImagesToUpload.add(image);
        // }
      }
    }
  }

  void uploadImageConfirmation() {
    if (selectedPath.value == MediaCategory.folders) {
      TLoaders.warningSnackBar(
          title: 'Select Folder',
          message: 'PLease select the Folder in Order to upload the Image.');
      return;
    }
    TDialogs.defaultDialog(
      context: Get.context!,
      title: 'Upload Images',
      confirmText: 'Upload',
      onConfirm: () async => await uploadImages(),
      content:
      'Are you sure want to upload all the Images in ${selectedPath.value.name
          .toUpperCase()} folder?',
    );
  }

  Future<void> uploadImages() async {
    try {
      // Remove confirmation box
      Get.back();

      // Loader
      uploadImagesLoader();

      // Get the selected category
      MediaCategory selectedCategory = selectedPath.value;

      // Get the corresponding list to update
      RxList<ImageModel> targetList;

      switch (selectedCategory) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;
        default:
          return;
      }

      // Upload and add Images to the target list
      // Using a reverse loop to avoid 'Concurrent modification during iteration' error
      for (int i = selectedImagesToUpload.length - 1; i >= 0; i--) {
        var selectedImage = selectedImagesToUpload[i];
        final image = selectedImage.localImageToDisplay!;
        // Upload Image to the Storage
        final uploadedImage =
        await mediaRepository.uploadImageFileInStorage(
            file: image,
            path: getSelectedPath(),
            imageName: selectedImage.filename);
        // Upload Image to the FireStore
        uploadedImage.mediaCategory = selectedCategory.name;
        final id = await mediaRepository.uploadImageFileInDatabase(
            uploadedImage);

        uploadedImage.id = id;

        selectedImagesToUpload.removeAt(i);
        targetList.add(uploadedImage);
      }
      TFullScreenLoader.stopLoading();
    } catch (e) {
      // Stop Loader in case of an error
      TFullScreenLoader.stopLoading();
      // Show a warning snack-bar for the error
      TLoaders.warningSnackBar(
          title: 'Error Uploading Images',
          message: 'Something went wrong while uploading your images.');
    }
  }

  void uploadImagesLoader() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) =>
          PopScope(
              canPop: false,
              child: AlertDialog(
                title: const Text('Uploading Images'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      TImages.uploadingImageIllustration,
                      height: 300,
                      width: 300,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    const Text('Sit Tight, Your images are uploading...'),
                  ],
                ),
              )),
    );
  }

  String getSelectedPath() {
    String path = '';
    switch (selectedPath.value) {
      case MediaCategory.banners:
        path = TTexts.bannersStoragePath;
        break;
      case MediaCategory.brands:
        path = TTexts.brandsStoragePath;
        break;
      case MediaCategory.categories:
        path = TTexts.categoriesStoragePath;
        break;
      case MediaCategory.products:
        path = TTexts.productsStoragePath;
        break;
      case MediaCategory.users:
        path = TTexts.usersStoragePath;
        break;
      default:
        path = 'Others';
    }
    return path;
  }

  void removeCloudImageConfirmation(ImageModel image){
    TDialogs.defaultDialog(context: Get.context!,
      content: 'Are you sure you want to delete this image?',
        onConfirm: (){
      Get.back();

      removeCloudImage(image);
        }
    );
  }

  Future<void> removeCloudImage(ImageModel image) async{
    try{
      Get.back();

      // show loader
      Get.defaultDialog(
        title: '',
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const PopScope(canPop: false,child: SizedBox(height: 150,width: 150,child: TCircularLoader(),))
      );

      // Delete Image
      await mediaRepository.deleteFileFromStorage(image);

      RxList<ImageModel> targetList;

      switch(selectedPath.value){
        case MediaCategory.banners :
          targetList = allBannerImages;
          break;
        case MediaCategory.brands :
          targetList = allBrandImages;
          break;
        case MediaCategory.categories :
          targetList = allCategoryImages;
          break;
        case MediaCategory.products :
          targetList = allProductImages;
          break;
        case MediaCategory.users :
          targetList = allUserImages;
          break;
        default :
          return;
      }

      targetList.remove(image);

      update();

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: 'Image Deleted',message: 'Image successfully deleted from your cloud storage');
    }catch (e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap',message: e.toString());
    }
  }

  // Image Selection Bottom Sheet
Future<List<ImageModel>?> selectImagesFromMedia({List<String>? selectedUrls,bool allowSelection=true,bool multipleSelection = false})async{
    showImageUploaderSection.value = true;

    List<ImageModel>? selectedImages = await Get.bottomSheet<List<ImageModel>>(
      isScrollControlled: true,
      backgroundColor: TColors.primaryBackground,
      FractionallySizedBox(
        heightFactor: 1,
          child: SingleChildScrollView(
            child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                const MediaUploader(),
                MediaContent(allowSelection: allowSelection, allowMultipleSelection: multipleSelection,alreadySelectedUrls:selectedUrls ?? [],)
              ],
            ),),
          ),
      ),
    );
    return selectedImages;
  }
}
