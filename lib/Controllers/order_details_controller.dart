import 'dart:convert';

import 'package:get/get.dart';

import '/models/order_details.dart';
import '/services/api-list.dart';
import '/services/server.dart';

class OrderDetailsController extends GetxController {
  Server server = Server();
  var orderId;
  int? statusCode, deliveryBoyId, expectedTimeSeconds;
  Timer? timerData;
  String? total,
      orderCode,
      subTotal,
      deliveryCharge,
      taxRate,
      taxAmount,
      formattedTaxRate,
      formattedTaxAmount,
      serviceFeeRate,
      serviceFeeAmount,
      formattedServiceFeeRate,
      formattedServiceFeeAmount,
      statusName,
      createdTime,
      expectedTime,
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
        taxRate = orderDetailsData.data!.taxRate;
        taxAmount = orderDetailsData.data!.taxAmount;
        formattedTaxRate = orderDetailsData.data!.formattedTaxRate;
        formattedTaxAmount = orderDetailsData.data!.formattedTaxAmount;
        serviceFeeRate = orderDetailsData.data!.serviceFeeRate;
        serviceFeeAmount = orderDetailsData.data!.serviceFeeAmount;
        formattedServiceFeeRate =
            orderDetailsData.data!.formattedServiceFeeRate;
        formattedServiceFeeAmount =
            orderDetailsData.data!.formattedServiceFeeAmount;
        print(
          'Tax Debug: taxRate=$taxRate, taxAmount=$taxAmount, formattedTaxRate=$formattedTaxRate, formattedTaxAmount=$formattedTaxAmount',
        );
        print(
          'Service Fee Debug: serviceFeeRate=$serviceFeeRate, serviceFeeAmount=$serviceFeeAmount, formattedServiceFeeRate=$formattedServiceFeeRate, formattedServiceFeeAmount=$formattedServiceFeeAmount',
        );
        print('Full API Response: ${json.encode(jsonResponse)}');
        statusCode = orderDetailsData.data!.status!;
        statusName = orderDetailsData.data!.statusName!;
        createdTime = orderDetailsData.data!.createdAt!;
        expectedTime = orderDetailsData.data!.expectedTime;
        expectedTimeSeconds = orderDetailsData.data!.expectedTimeSeconds;
        timerData = orderDetailsData.data!.timer;
        print(
          'Order Details: statusCode=$statusCode, expectedTimeSeconds=$expectedTimeSeconds, timerData=${timerData?.remainingTime}',
        );
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
    server.getRequest(endPoint: APIList.orderCancel! + id.toString()).then((
      response,
    ) {
      if (response != null && response.statusCode == 200) {
        onInit();
      }
    });
  }
}
