import 'package:e_commerce_admin_pannel/features/shop/controllers/product/product_attribute_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/product_variationModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/popups/dialogs.dart';

class ProductVariationController extends GetxController {
  static ProductVariationController get instance => Get.find();

  final isLoading = false.obs;
  final RxList<ProductVariationModel> productVariations =
      <ProductVariationModel>[].obs;

  List<Map<ProductVariationModel, TextEditingController>> stockControllerList =
      [];
  List<Map<ProductVariationModel, TextEditingController>> priceControllerList =
      [];
  List<Map<ProductVariationModel, TextEditingController>>
      salePriceControllerList = [];
  List<Map<ProductVariationModel, TextEditingController>>
      descriptionControllerList = [];

  final attributeController = Get.isRegistered<ProductAttributeController>()
      ? ProductAttributeController.instance
      : Get.put(ProductAttributeController());


  void initializeVariationControllers(List<ProductVariationModel> variations) {
    // clear existing list
    stockControllerList.clear();
    priceControllerList.clear();
    salePriceControllerList.clear();
    descriptionControllerList.clear();

    // Initialize controllers for each variation
    for (var variation in variations) {
      // Stock Controller
      Map<ProductVariationModel, TextEditingController> stockController = {};
      stockController[variation] =
          TextEditingController(text: variation.stock.toString());
      stockControllerList.add(stockController);

      // Price Controller
      Map<ProductVariationModel, TextEditingController> priceController = {};
      priceController[variation] =
          TextEditingController(text: variation.price.toString());
      priceControllerList.add(priceController);

      // Sale Price Controller
      Map<ProductVariationModel, TextEditingController> salePriceController =
          {};
      salePriceController[variation] =
          TextEditingController(text: variation.salePrice.toString());
      salePriceControllerList.add(salePriceController);

      // Description Controller
      Map<ProductVariationModel, TextEditingController> descriptionController =
          {};
      descriptionController[variation] =
          TextEditingController(text: variation.description.toString());
      descriptionControllerList.add(descriptionController);
    }
  }

  void removeVariation(BuildContext context){
    TDialogs.defaultDialog(
      context: context,
      title: 'Remove Variations',
      onConfirm: () {
        productVariations.value == [];
        resetAllValues();
        Navigator.of(context).pop();
      },
    );
  }

  void generateVariationsConfirmation(BuildContext context) {
    TDialogs.defaultDialog(context: context,
    confirmText: 'Generate',
    title: 'Generate Variations',
    content: 'Once the Variation are created, you cannot add more attributes. In order to add more variations, you have delete any of the attributes.',
    onConfirm: () => generateVariationsFromAttributes(),);
  }

  void resetAllValues() {
    productVariations.clear();
    stockControllerList.clear();
    priceControllerList.clear();
    salePriceControllerList.clear();
    descriptionControllerList.clear();
  }

  generateVariationsFromAttributes() {
    Get.back();

    final List<ProductVariationModel> variations = [];

    if(attributeController.productAttributes.isNotEmpty){
      // Get all combinations of attribute values, [["Red", "Blue"], ["S", "M", "L"]]
      final List<List<String>> attributeCombinations =
          getCombinations(attributeController.productAttributes.map((e) => e.values ?? <String>[]).toList());



      for(final combination in attributeCombinations){
        final Map<String,String> attributeValues =
            Map.fromIterables(attributeController.productAttributes.map((e) => e.name ?? ''), combination);

        final ProductVariationModel variation = ProductVariationModel(
          id: UniqueKey().toString(),
          attributeValue: attributeValues
        );

        variations.add(variation);

        // Create Controller
        final Map<ProductVariationModel, TextEditingController> stockController = {};
        final Map<ProductVariationModel, TextEditingController> priceController = {};
        final Map<ProductVariationModel, TextEditingController> salePriceController = {};
        final Map<ProductVariationModel, TextEditingController> descriptionController = {};

        // Assuming variation is your ProductVariationModel
        stockController[variation] = TextEditingController();
        priceController[variation] = TextEditingController();
        salePriceController[variation] = TextEditingController();
        descriptionController[variation] = TextEditingController();

        // Add the maps to their respective lists
        stockControllerList.add(stockController);
        priceControllerList.add(priceController);
        salePriceControllerList.add(salePriceController);
        descriptionControllerList.add(descriptionController);
      }
    }

    productVariations.assignAll(variations);
  }


  List<List<String>> getCombinations(List<List<String>> lists) {
    final List<List<String>> result = [];

    // Start combining attributes from the first one
    combine(lists,0,<String>[],result);

    return result;
  }

  void combine(List<List<String>> lists, int i, List<String> list, List<List<String>> result) {
    // Base case: All attributes have been combined and added to the result
    // list. Add the current combination to the result list.
    if (i == lists.length) {
      result.add(List.from(list));
      return;
    }
    // Iterate over each item in the current attribute list and recursively combine the remaining attributes.
    for (final item in lists[i]) {
      final List<String> updated = List.from(list)..add(item);

      // Recursively combine the remaining attributes
      combine(lists, i + 1, updated, result);
    }

  }
}
