import 'package:data_table_2/data_table_2.dart';
import 'package:e_commerce_admin_pannel/common/widgets/data_table/paginated_data_table.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/customer/all_customer/table/table_source.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/product/all_products/table/table_source.dart';
import 'package:e_commerce_admin_pannel/utils/device/device_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../controllers/customer/customer_controller.dart';

class CustomerTable extends StatelessWidget{
  const CustomerTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerController.instance;
    return Obx(
      () {
        Visibility(child: Text(controller.allItems.length.toString()),visible: false,);
        Visibility(child: Text(controller.filteredItems.length.toString()),visible: false,);
        return TPaginatedDataTable(
          minWidth: 700,
          columns: [
            DataColumn2(label: Text('Customer'),
                fixedWidth:!TDeviceUtils.isDesktopScreen(context) ? 300 : 400,onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending), ),
            DataColumn2(label: Text('Email')),
            DataColumn2(label: Text('Phone Number')),
            DataColumn2(label: Text('Registered')),
            DataColumn2(label: Text('Action'),fixedWidth: 100),
          ], source:CustomerRows() );
      },
    );
  }

}