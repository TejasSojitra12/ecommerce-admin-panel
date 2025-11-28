import 'package:e_commerce_admin_pannel/features/media/controllers/media_controller.dart';
import 'package:e_commerce_admin_pannel/features/media/models/image_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/product_variationModel.dart';
import 'package:get/get.dart';

class ProductImageController extends GetxController {
  static ProductImageController get instance => Get.find();

  // Rx Observables for the selected thumbnail image
  Rx<String?> selectedThumbnailImageUrl = Rx<String?>(null);

// Lists to store additional product image
  final RxList<String> additionalProductImagesUrls = <String>[].obs;

  /// Function to remove Product Image
  Future<void> removeImage(int index) async {
    additionalProductImagesUrls.removeAt(index);
  }

  /// Pick Thumbnail image From the Media
  void selectThumbnailImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // set the selected image to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Upload the main image using the selectedImage
      selectedThumbnailImageUrl.value = selectedImage.url;
    }
  }

  /// Pick Multiple Images From the Media
  void selectMultipleProductImage() async {
    final controller = Get.put(MediaController());
    final List<ImageModel>? selectedImages =
        await controller.selectImagesFromMedia(multipleSelection: true);

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      additionalProductImagesUrls.assignAll(selectedImages.map((e) => e.url));
    }
  }

  /// Pick Thumbnail Image from Media
  void selectVariationImage(ProductVariationModel variation) async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // set the selected image to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Upload the main image using the selectedImage
      variation.image.value = selectedImage.url;
    }
  }

  void resetAllValues(){
    selectedThumbnailImageUrl.value = null;
    additionalProductImagesUrls.clear();
  }
}
