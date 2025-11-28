import 'package:data_table_2/data_table_2.dart';
import 'package:e_commerce_admin_pannel/common/widgets/containers/rounded_container.dart';
import 'package:e_commerce_admin_pannel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:e_commerce_admin_pannel/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_admin_pannel/features/authentication/models/user/user_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/customer/customer_detail_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/order_model.dart';
import 'package:e_commerce_admin_pannel/features/shop/models/product_model.dart';
import 'package:e_commerce_admin_pannel/routes/routes.dart';
import 'package:e_commerce_admin_pannel/utils/constants/colors.dart';
import 'package:e_commerce_admin_pannel/utils/constants/enums.dart';
import 'package:e_commerce_admin_pannel/utils/constants/image_strings.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:e_commerce_admin_pannel/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerOrderRows extends DataTableSource {
  final controller = CustomerDetailController.instance;
  @override
  DataRow? getRow(int index) {

    final order = controller.filteredCustomerOrders[index];
    final totalAmount = order.items.fold(0.0, (previousValue, element) => previousValue + element.price,);
    return DataRow2(
        selected: controller.selectedRows[index],
        onTap: () => Get.toNamed(TRoutes.ordersDetails, arguments: order),
        onSelectChanged: controller.selectedRows[index] ? (value) => controller.selectedRows[index] = value! : null,
        cells: [
          DataCell(Text(order.id,style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),)),
          DataCell(Text(order.formattedOrderDate)),
          DataCell(Text('${order.items.length} Items')),
          DataCell(TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: EdgeInsets.symmetric(vertical: TSizes.sm,horizontal: TSizes.md),
            backgroundColor: THelperFunctions.getOrderStatusColor(order.status).withOpacity(0.1),
            child: Text(order.status.name.capitalize.toString(),
            style: TextStyle(color: THelperFunctions.getOrderStatusColor(order.status)),),
          )),
          DataCell(Text('\$$totalAmount')),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredCustomerOrders.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((element) => element).length;
}
