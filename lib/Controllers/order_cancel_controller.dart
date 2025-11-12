import 'dart:convert';

import '/Controllers/order_details_controller.dart';
import '/models/order_cancel.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import 'package:get/get.dart';

class OrderCancelController extends GetxController {
  Server server = Server();
  var orderId;
  String? message;

  OrderCancelController(this.orderId);

  @override
  void onInit() {
    orderId = Get.find<OrderDetailsController>().orderId;
    cancelOrder(orderId);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  cancelOrder(int id) {
    server
        .getRequest(endPoint: APIList.orderCancel! + id.toString())
        .then((response) {
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var cancelOrderData = OrderCancel.fromJson(jsonResponse);
        message = cancelOrderData.message;
      }
    });
  }
}
