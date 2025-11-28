import 'package:data_table_2/data_table_2.dart';
import 'package:e_commerce_admin_pannel/common/widgets/data_table/paginated_data_table.dart';
import 'package:e_commerce_admin_pannel/features/shop/controllers/order/order_controller.dart';
import 'package:e_commerce_admin_pannel/features/shop/screens/order/all_orders/table/table_source.dart';
import 'package:e_commerce_admin_pannel/utils/constants/sizes.dart';
import 'package:e_commerce_admin_pannel/utils/device/device_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DashboardOrderTable extends StatelessWidget{
  const DashboardOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OrderController.instance;
    return Obx(
        (){
          Text(controller.filteredItems.length.toString());
          Text(controller.allItems.length.toString());
          return TPaginatedDataTable(
              minWidth: 700,
              tableHeight: 500,
              dataRowHeight: TSizes.xl *1.2,
              sortAscending: controller.sortAscending.value,
              sortColumnIndex: controller.sortColumnIndex.value,
              columns: [
                DataColumn2(label: Text('Order ID'),onSort: (columnIndex, ascending) => controller.sortById(columnIndex, ascending),),
                DataColumn2(label: Text('Date')),
                DataColumn2(label: Text('Items')),
                DataColumn2(label: Text('Status'),fixedWidth: TDeviceUtils.isMobileScreen(context) ? 120 :null),
                DataColumn2(label: Text('Actions')),
          ], source: OrderRows());
        }
    );
  }
}