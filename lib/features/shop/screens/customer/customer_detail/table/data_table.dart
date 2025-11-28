import 'package:data_table_2/data_table_2.dart';
import 'package:e_commerce_admin_pannel/common/widgets/data_table/paginated_data_table.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/customer/customer_detail_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/customer/customer_detail/table/table_source.dart';
import 'package:e_commerce_admin_pannel/utils/device/device_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerOrderTable extends StatelessWidget{
  const CustomerOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    return Obx(
      () {
        Visibility(child: Text(controller.allCustomerOrders.length.toString()),visible: false,);
        Visibility(child: Text(controller.filteredCustomerOrders.length.toString()),visible: false,);
        return TPaginatedDataTable(
          minWidth: 550,
          tableHeight: 640,
          dataRowHeight: kMinInteractiveDimension,
          sortColumnIndex: controller.sortColumnIndex.value,
          sortAscending: controller.sortAscending.value,
          columns: [
            DataColumn2(label: Text('Order ID'),onSort: (columnIndex, ascending) => controller.sortById(columnIndex, ascending),),
            DataColumn2(label: Text('Date')),
            DataColumn2(label: Text('Items')),
            DataColumn2(label: Text('Status'),fixedWidth: TDeviceUtils.isMobileScreen(context) ?100:null),
            DataColumn2(label: Text('Amount'),numeric: true),
          ], source:CustomerOrderRows() );
      },
    );
  }

}