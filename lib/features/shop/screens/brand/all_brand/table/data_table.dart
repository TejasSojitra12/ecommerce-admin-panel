import 'package:data_table_2/data_table_2.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/brand/brand_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/brand/all_brand/table/table_source.dart';
import 'package:e_commerce_admin_pannel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/paginated_data_table.dart';

class BrandTable extends StatelessWidget{
  const BrandTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
   return Obx(
     () {
       Text(controller.filteredItems.length.toString());
       Text(controller.selectedRows.length.toString());
       
       final lgTable = controller.filteredItems.any((element) =>element.brandCategories != null && element.brandCategories!.length >2 ,);
       return TPaginatedDataTable(
       minWidth: 700,
         dataRowHeight: lgTable ? 96 : 64,
         tableHeight: lgTable ? 96 * 11.5 : 760,
         sortAscending: controller.sortAscending.value,
         sortColumnIndex: controller.sortColumnIndex.value,
         columns: [
       DataColumn2(label: const Text('Brand'),
       fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 200,
         onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending),
       ),
       const DataColumn2(label: Text('Categories')),
       DataColumn2(label: const Text('Featured'),fixedWidth: TDeviceUtils.isMobileScreen(Get.context!)?null:100),
       DataColumn2(label: const Text('Date'),fixedWidth: TDeviceUtils.isMobileScreen(Get.context!)?null:200),
       DataColumn2(label: const Text('Action'),fixedWidth: TDeviceUtils.isMobileScreen(Get.context!)?null:100),
     ],
         source: BrandRows() );
     },
   );
  }

}