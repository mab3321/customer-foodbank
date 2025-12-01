import 'dart:convert';

import '/models/oder_list.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import 'package:get/get.dart';

class OrderListController extends GetxController {
  Server server = Server();
  List<Datum> orderList = <Datum>[];
  int? orderId;
  bool orderLoader = true;

  @override
  void onInit() {
    print('OrderListController: onInit called');
    orderLoader = true;
    getOrderList();
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    super.onInit();
  }

  getOrderList() async {
    print('OrderListController: Fetching orders from API...');
    server.getRequest(endPoint: APIList.orders).then((response) {
      print(
        'OrderListController: API Response - StatusCode: ${response?.statusCode}',
      );
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print('OrderListController: Successfully received response');
        var orderData = OrderList.fromJson(jsonResponse);
        orderList = <Datum>[];
        orderList.addAll(orderData.data!);
        print(
          'OrderListController: Successfully loaded ${orderList.length} orders',
        );
        orderLoader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        print(
          'OrderListController: API Error - StatusCode: ${response?.statusCode}',
        );
      }
    });
  }
}
