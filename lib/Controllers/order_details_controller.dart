import 'dart:convert';

import 'package:get/get.dart';

import '/models/order_details.dart';
import '/services/api-list.dart';
import '/services/server.dart';

class OrderDetailsController extends GetxController {
  Server server = Server();
  var orderId;
  int? statusCode, deliveryBoyId;
  String? total,
      orderCode,
      subTotal,
      deliveryCharge,
      statusName,
      createdTime,
      restaurantName,
      restaurantImage,
      restaurantAddress,
      deliveryBoyName,
      deliveryBoyEmail,
      deliveryBoyPhone,
      deliveryBoyImage,
      resLat,
      resLong;
  bool orderDetailsDataLoader = true;
  List<Item> itemList = <Item>[];

  OrderDetailsController(this.orderId);

  @override
  void onInit() {
    orderDetailsDataLoader = true;
    getOrderDetails(orderId);
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    super.onInit();
  }

  getOrderDetails(var id) async {
    server.getRequestWithParamOrders(orderId: id).then((response) {
      if (response != null && response.statusCode == 200) {
        orderDetailsDataLoader = false;
        final jsonResponse = json.decode(response.body);
        var orderDetailsData = OrderDetailsData.fromJson(jsonResponse['data']);
        itemList = <Item>[];
        itemList.addAll(orderDetailsData.data!.items!);
        orderId = orderDetailsData.data!.id!;
        orderCode = orderDetailsData.data!.orderCode!;
        total = orderDetailsData.data!.total!;
        subTotal = orderDetailsData.data!.subTotal!;
        deliveryCharge = orderDetailsData.data!.deliveryCharge!;
        statusCode = orderDetailsData.data!.status!;
        statusName = orderDetailsData.data!.statusName!;
        createdTime = orderDetailsData.data!.createdAt!;
        restaurantName = orderDetailsData.data!.restaurant!.name!;
        restaurantImage = orderDetailsData.data!.restaurant!.image!;
        restaurantAddress = orderDetailsData.data!.restaurant!.address!;
        resLat = orderDetailsData.data!.restaurant!.lat!;
        resLong = orderDetailsData.data!.restaurant!.long!;
        deliveryBoyId = orderDetailsData.data!.deliveryBoy!.id;
        deliveryBoyName = orderDetailsData.data!.deliveryBoy!.name;
        deliveryBoyEmail = orderDetailsData.data!.deliveryBoy!.email;
        deliveryBoyPhone = orderDetailsData.data!.deliveryBoy!.phone;
        deliveryBoyImage = orderDetailsData.data!.deliveryBoy!.image;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {}
    });
  }

  cancelOrder(int id) {
    orderDetailsDataLoader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    server
        .getRequest(endPoint: APIList.orderCancel! + id.toString())
        .then((response) {
      if (response != null && response.statusCode == 200) {
        onInit();
      }
    });
  }
}
