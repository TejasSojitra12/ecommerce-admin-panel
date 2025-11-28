import 'package:data_table_2/data_table_2.dart';
import 'package:e_commerce_admin_pannel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:e_commerce_admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/product_model.dart';
import 'package:e_commerce_admin_pannel/routes/routes.dart';
import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductRows extends DataTableSource {
  final controller = ProductController.instance;

  @override
  DataRow? getRow(int index) {
    final product = controller.filteredItems[index];
    final hasNetworkImage =
        product.images != null && product.images!.isNotEmpty;
    return DataRow2(
        selected: controller.selectedRows[index],
        onTap: () => Get.toNamed(TRoutes.editProduct,arguments: product),
        onSelectChanged: (value) =>
            controller.selectedRows[index] = value ?? false,
        cells: [
          DataCell(Row(
            children: [
              TRoundedImage(
                width: 50,
                height: 50,
                padding: TSizes.xs,
                image: hasNetworkImage
                    ? product.thumbnail
                    : TImages.defaultImage,
                imageType:
                    hasNetworkImage ? ImageType.network : ImageType.asset,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ),
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Flexible(
                  child: Text(
                product.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(Get.context!)
                    .textTheme
                    .bodyLarge!
                    .apply(color: TColors.primary),
              ))
            ],
          )),
          DataCell(Text(controller.getProductStockTotal(product))),
          DataCell(Text(controller.getProductSoldQuantity(product))),
          DataCell(Row(
            children: [
              TRoundedImage(
                width: 35,
                height: 35,
                padding: TSizes.xs,
                image: product.brand?.image ?? TImages.defaultImage,
                imageType: (product.brand?.image!= null && product.brand!.image.isNotEmpty)  ? ImageType.network : ImageType.asset,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.borderPrimary,
              ),
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Flexible(
                  child: Text(
                product.brand?.name ?? "",
                style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(
                    color: TColors.primary, overflow: TextOverflow.ellipsis),
              ))
            ],
          )),
          DataCell(Text('\$${controller.getProductPrice(product)}')),
          DataCell(Text(product.formattedDate)),
          DataCell(TTableActionButtons(
            onEditPressed: () => Get.toNamed(TRoutes.editProduct,
                arguments: product),
            onDeletePressed: () => controller.confirmAndDeleteItem(product),
          )),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((element) => element).length;
}
