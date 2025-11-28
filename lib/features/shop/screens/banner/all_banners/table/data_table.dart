import 'package:data_table_2/data_table_2.dart';
import 'package:e_commerce_admin_pannel/common/widgets/data_table/paginated_data_table.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/banner/all_banners/table/table_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/banner/banner_controller.dart';

class BannerTable extends StatelessWidget {
  const BannerTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(
      () {
        Text(controller.filteredItems.length.toString());
        Text(controller.selectedRows.length.toString());
        return TPaginatedDataTable(
        minWidth: 700,
            tableHeight: 900,
          dataRowHeight: 110,
          sortColumnIndex: controller.sortColumnIndex.value,
          sortAscending: controller.sortAscending.value,
          columns: const [
            DataColumn2(label: Text('Banner')),
            DataColumn2(label: Text('Redirect Screen')),
            DataColumn2(label: Text('Active')),
            DataColumn2(label: Text('Action'),fixedWidth: 100),
          ],
          source: BannerRows());
      },
    );
  }
}
