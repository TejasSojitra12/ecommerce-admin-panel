import 'package:e_commerce_admin_pannel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/product_attribute_model.dart';
import 'package:e_commerce_admin_pannel/utils/popups/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductAttributeController extends GetxController {
  static ProductAttributeController get instance => Get.find();

  final isLoading = false.obs;
  final attributesFormKey = GlobalKey<FormState>();
  TextEditingController attributeName = TextEditingController();
  TextEditingController attributes = TextEditingController();
  final RxList<ProductAttributeModel> productAttributes =
      <ProductAttributeModel>[].obs;

  // Function to add a new attribute
  void addNewAttribute() {
    // Form Validation
    if (!attributesFormKey.currentState!.validate()) {
      return;
    }

    // add Attribute to the list of attribute
    productAttributes.add(ProductAttributeModel(
      name: attributeName.text.trim(),
      values: attributes.text.trim().split('|').toList(),
    ));

    // Clear the input fields
    attributeName.text = '';
    attributes.text = '';

  }

  // Function to remove an attribute
void removeAttribute(int index, BuildContext context){
    // Show a confirmation dialog before removing the attribute
  TDialogs.defaultDialog(context: context,
    onConfirm: () {
      Navigator.of(context).pop();
      productAttributes.removeAt(index);

      // Reset Product Variation when removing an attribute
      ProductVariationController.instance.productVariations.value = [];
    },
    onCancel: () {
      Navigator.of(context).pop();
    },
  );
}

void resetAttributes() {
  productAttributes.clear();
}

}
