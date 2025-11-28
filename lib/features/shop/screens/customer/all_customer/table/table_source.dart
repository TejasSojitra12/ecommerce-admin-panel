import 'package:data_table_2/data_table_2.dart';
import 'package:e_commerce_admin_pannel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:e_commerce_admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_admin_pannel/features/authentication/models/user/user_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/customer/customer_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/product_model.dart';
import 'package:e_commerce_admin_pannel/routes/routes.dart';
import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerRows extends DataTableSource {
  final controller = CustomerController.instance;
  @override
  DataRow? getRow(int index) {
    final customer = controller.filteredItems[index];
    return DataRow2(
      onTap: () => Get.toNamed(TRoutes.customerDetails,arguments: customer),
        selected: controller.selectedRows[index],
        onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
        cells: [
      DataCell(Row(
        children: [
               TRoundedImage(
              width: 50,
              height: 50,
              padding: TSizes.sm,
              image:customer.profilePicture.isNotEmpty ? customer.profilePicture: TImages.defaultImage,
              imageType: customer.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
              borderRadius: TSizes.borderRadiusMd,
              backgroundColor: TColors.primaryBackground,
            ),
          SizedBox(
            width: TSizes.spaceBtwItems,
          ),
          Flexible(
              child: Text(
                customer.fullName,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(Get.context!)
                    .textTheme
                    .bodyLarge!
                    .apply(color: TColors.primary),
                maxLines: 2,
              ),
          )
        ],
      )),
      DataCell(Text(customer.email)),
      DataCell(Text(customer.formatedPhoneNo)),
      DataCell(Text(customer.formattedDate)),
      DataCell(TTableActionButtons(
        view: true,
        edit: false,
        onViewPressed: () => Get.toNamed(TRoutes.customerDetails,arguments: customer),
        onDeletePressed: ()=> controller.confirmAndDeleteItem(customer),
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
