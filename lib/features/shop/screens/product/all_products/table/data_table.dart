import 'package:data_table_2/data_table_2.dart';
import 'package:e_commerce_admin_pannel/common/widgets/data_table/paginated_data_table.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/product/all_products/table/table_source.dart';
import 'package:e_commerce_admin_pannel/utils/device/device_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../controllers/product/product_controller.dart';

class ProductTable extends StatelessWidget{
  const ProductTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
   return Obx(
     () {
       Text(controller.filteredItems.length.toString());
       Text(controller.selectedRows.length.toString());
       return TPaginatedDataTable(
         minWidth: 1000,
         sortColumnIndex: controller.sortColumnIndex.value,
         sortAscending: controller.sortAscending.value,
         columns: [
           DataColumn2(label: Text('Product'),
               fixedWidth:!TDeviceUtils.isDesktopScreen(context) ? 300 : 400 ,onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending),),
           DataColumn2(label: Text('Stock'),onSort: (columnIndex, ascending) => controller.sortByStock(columnIndex, ascending),),
           DataColumn2(label: Text('Sold'),onSort: (columnIndex, ascending) => controller.sortBySoldItems(columnIndex, ascending),),
           DataColumn2(label: Text('Brand')),
           DataColumn2(label: Text('Price'),onSort: (columnIndex, ascending) => controller.sortByPrice(columnIndex, ascending),),
           DataColumn2(label: Text('Date')),
           DataColumn2(label: Text('Action'),fixedWidth: 100),
         ], source:ProductRows() );
     },
   );
  }

}