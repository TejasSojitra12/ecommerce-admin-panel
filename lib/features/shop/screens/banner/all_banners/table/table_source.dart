
import 'package:data_table_2/data_table_2.dart';
import 'package:e_commerce_admin_pannel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:e_commerce_admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/banner_model.dart';
import 'package:e_commerce_admin_pannel/routes/routes.dart';
import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../controllers/banner/banner_controller.dart';

class BannerRows extends DataTableSource{
  final controller = BannerController.instance;

  @override
  DataRow? getRow(int index) {
    final banner = controller.filteredItems[index];
    return DataRow2(
        selected: controller.selectedRows[index],
        onSelectChanged: (value) =>
            controller.selectedRows[index] = value ?? false,
        onTap: () => Get.toNamed(TRoutes.editBanner,arguments: banner),
        cells: [
       DataCell(TRoundedImage(
        width: 180,
        height: 100,
        padding: TSizes.sm,
        image: banner.imageUrl,
        imageType: ImageType.network,
        borderRadius: TSizes.borderRadiusMd,
        backgroundColor: TColors.primaryBackground,
      )),
       DataCell(Text(controller.formatRoute(banner.targetScreen))),
       DataCell(banner.active ? Icon(Iconsax.eye,color: TColors.primary,) : Icon(Iconsax.eye_slash)),
      DataCell(TTableActionButtons(
        onEditPressed: ()=>Get.toNamed(TRoutes.editBanner,arguments: banner),
        onDeletePressed: ()=>controller.confirmAndDeleteItem(banner),

      ))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount =>controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected,).length;

}