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
    orderLoader = true;
    getOrderList();
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    super.onInit();
  }

  getOrderList() async {
    server.getRequest(endPoint: APIList.orders).then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var orderData = OrderList.fromJson(jsonResponse);
        orderList = <Datum>[];
        orderList.addAll(orderData.data!);
        orderLoader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {}
    });
  }
}
