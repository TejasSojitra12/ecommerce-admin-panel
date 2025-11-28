import 'package:data_table_2/data_table_2.dart';
import 'package:e_commerce_admin_pannel/common/widgets/data_table/paginated_data_table.dart';

import 'package:e_commerce_admin_pannel/features/shop/screens/order/all_orders/table/table_source.dart';

import 'package:e_commerce_admin_pannel/utils/device/device_utility.dart';
import 'package:flutter/cupertino.dart';

class OrderTable extends StatelessWidget {
  const OrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
        minWidth: 700,
        columns: [
          DataColumn2(
            label: Text('Order ID'),
          ),
          DataColumn2(label: Text('Date')),
          DataColumn2(label: Text('Items')),
          DataColumn2(
              label: Text('Status'),
              fixedWidth: TDeviceUtils.isMobileScreen(context) ? 120 : null),
          DataColumn2(label: Text('Amount')),
          DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: OrderRows());
  }
}
