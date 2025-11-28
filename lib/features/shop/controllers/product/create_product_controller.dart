import 'package:e_commerce_admin_pannel/features/shop/controllers/product/product_attribute_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/product_image_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/barnd_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/category_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/product_category_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/product_model.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:e_commerce_admin_pannel/utils/helpers/network_manager.dart';
import 'package:e_commerce_admin_pannel/utils/popups/full_screen_loader.dart';
import 'package:e_commerce_admin_pannel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/product/product_repository.dart';

class CreateProductController extends GetxController {
  static CreateProductController get instance => Get.find();

  final isLoading = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  final stockPriceFormKey = GlobalKey<FormState>();
  final productRepository = Get.find<ProductRepository>();
  final titleDescriptionFormKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  // Flags for tracking different Task
  RxBool thumbnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  Future<void> createProduct() async {
    try {
      // show progress dialog
      showProgressDialog();

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Validate title and description form
      if (!titleDescriptionFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Ensure brand is selected
      if (selectedBrand.value == null) throw 'Select Brand for this product';

      // Check variation data if ProductType = Variable
      if (productType.value == ProductType.variable &&
          ProductVariationController.instance.productVariations.isEmpty) {
        throw 'There are no variations for the Product Type Variable. Create some variations or change product type.';
      }
      if (productType.value == ProductType.variable) {
        final variationCheckFailed = ProductVariationController
            .instance.productVariations
            .any((element) =>
        element.price.isNaN ||
            element.stock < 0 ||
            element.salePrice.isNaN ||
            element.salePrice < 0 ||
            element.stock.isNaN ||
            element.stock < 0 ||
            element.image.value.isEmpty
        );

        if (variationCheckFailed) throw 'Variation data is not accurate. Please recheck variations';
      }

      // Upload Product Thumbnail Image
      thumbnailUploader.value = true;
      final imagesController = ProductImageController.instance;
      if (imagesController.selectedThumbnailImageUrl.value ==
          null) throw 'Select Product Thumbnail Image';

      // Additional Product Images
      additionalImagesUploader.value = true;

      // Product Variation Images
      final variation = ProductVariationController.instance.productVariations;
      if (productType.value == ProductType.single && variation.isNotEmpty) {
        // If admin added variation and then changed the Product Type, remove all variations
        ProductVariationController.instance.resetAllValues();
        variation.value = [];
      }

      // Map Product Data to Product Model
      final newRecord = ProductModel(
        id: '',
        sku: '',
        isFeatured: true,
        title: title.text.trim(),
        brand: selectedBrand.value,
        productVariations: variation.value,
        discription: description.text.trim(),
        productType: productType.value.toString(),
        stock: int.tryParse(stock.text.trim()) ?? 0,
        price: double.tryParse(price.text.trim()) ?? 0.0,
        images: imagesController.additionalProductImagesUrls,
        salePrice: double.tryParse(salePrice.text.trim()) ?? 0.0,
        thumbnail: imagesController.selectedThumbnailImageUrl.value ?? '',
        productAttributes: ProductAttributeController.instance.productAttributes,
        date: DateTime.now(),
      );

      // call repository to create new product
      productDataUploader.value = true;
      newRecord.id = await ProductRepository.instance.createProduct(newRecord);

      // Register product categories if any
      if(selectedCategories.isNotEmpty){
        if(newRecord.id.isEmpty) throw 'Error storing data. Try again';

        // Loop through selected product categories
        categoriesRelationshipUploader.value = true;
        for(final category in selectedCategories){
          final productCategory = ProductCategoryModel(productId: newRecord.id, categoryId: category.id);
          await ProductRepository.instance.createProductCategory(productCategory);
        }
      
      }

      // update product list
      ProductController.instance.addItemToLists(newRecord);

      // close the Progress Loader
      TFullScreenLoader.stopLoading();

      // Show Success Message Loader
      showCompletionDialog();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
      print(e);
    }
  }

  // Reset form values and flags
  void resetFormValues(){
    isLoading.value = false;
    productType.value = ProductType.single;
    productVisibility.value = ProductVisibility.hidden;
    stockPriceFormKey.currentState?.reset();
    titleDescriptionFormKey.currentState?.reset();
    title.clear();
    stock.clear();
    price.clear();
    salePrice.clear();
    description.clear();
    brandTextField.clear();
    selectedBrand.value = null;
    selectedCategories.clear();
    ProductVariationController.instance.resetAllValues();
    ProductAttributeController.instance.resetAttributes();
   if(Get.isRegistered<ProductImageController>()){
     ProductImageController.instance.resetAllValues();
   }
    thumbnailUploader.value = false;
    additionalImagesUploader.value = false;
    productDataUploader.value = false;
    categoriesRelationshipUploader.value = false;

  }

  void showProgressDialog() {
    showDialog(context: Get.context!,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text('Create Product'),
          content:  Column(mainAxisSize: MainAxisSize.min,children: [
            Image.asset(TImages.creatingProductIllustration,height: 200,width: 200,),
            SizedBox(height: TSizes.spaceBtwItems,),
            buildCheckbox('Thumbnail Image',thumbnailUploader),
            buildCheckbox('Additional Images',additionalImagesUploader),
            buildCheckbox('Product Data, Attributes & Variations',productDataUploader),
            buildCheckbox('Product Categories',categoriesRelationshipUploader),
            SizedBox(height: TSizes.spaceBtwItems,),
            Text('Sit Tight, Your product is uploading...'),
          ],),
        ),
      ),);
  }

  void showCompletionDialog(){
    Get.dialog(AlertDialog(title: Text('Congratulations'),
    actions: [
      TextButton(onPressed: () {
        Get.back();
        Get.back();
      }, child: Text('Go to Products'))
    ],
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(TImages.productsIllustration,height: 200,width: 200,),
        SizedBox(height: TSizes.spaceBtwItems,),
        Text('Congratulations', style: Theme.of(Get.context!).textTheme.headlineSmall,),
        SizedBox(height: TSizes.spaceBtwItems,),
        Text('Your Product has been Created Successfully'),
      ],
    ),));
  }

  buildCheckbox(String s, RxBool thumbnailUploader) {
    return Row(
      children: [
        Obx(()=> Checkbox(value: thumbnailUploader.value, onChanged: (value) => thumbnailUploader.value = value ?? false,)),
        SizedBox(width: TSizes.spaceBtwItems,),
        Text(s),
      ]
    );
  }
}
