import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '/Controllers/global-controller.dart';
import '/Controllers/order_list_controller.dart';
import '/utils/font_size.dart';
import '/utils/theme_colors.dart';
import '/widgets/shimmer/order_list_shimmer.dart';
import 'no_order_found.dart';
import 'order_details.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  var mainHeight, mainWidth;
  OrderListController orderListController = Get.put(OrderListController());
  Future<Null> _onRefresh() {
    setState(() {
      orderListController.onInit();
    });
    Completer<Null> completer = new Completer<Null>();
    Timer(new Duration(seconds: 3), () {
      completer.complete();
    });
    return completer.future;
  }

  @override
  void initState() {
    orderListController.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _onRefresh();
    });
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MY_ORDERS".tr,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: FontSize.xLarge,
              color: Colors.white),
        ),
        backgroundColor: ThemeColors.baseThemeColor,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: GetBuilder<OrderListController>(
          init: OrderListController(),
          builder: (orders) => orders.orderLoader
              ? OrderListShimmer()
              : orders.orderList.isEmpty
                  ? NoOrderFound()
                  : RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView.builder(
                        itemCount: orders.orderList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.to(OrderDetails(
                                  orderId: orders.orderList[index].id));
                            },
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 15),
                                    Card(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: ExpansionTile(
                                        key: Key(index.toString()), //attention
                                        initiallyExpanded: index == 0,
                                        title: Container(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "ORDER_NO".tr +
                                                            " #${orders.orderList[index].orderCode}",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        "${orders.orderList[index].createdAtConvert}",
                                                        style: TextStyle(
                                                          overflow:
                                                              TextOverflow.fade,
                                                          fontSize:
                                                              FontSize.small,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "${Get.find<GlobalController>().currencyCode!}"
                                                        "${orders.orderList[index].total}",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        orders.orderList[index]
                                                            .paymentMethodName!,
                                                        style: TextStyle(
                                                          overflow:
                                                              TextOverflow.fade,
                                                          fontSize:
                                                              FontSize.small,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        children: [
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemCount: orders
                                                .orderList[index].items!.length,
                                            itemBuilder: (context, itemIndex) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 15,
                                                        right: 15,
                                                        bottom: 2),
                                                  ),
                                                  Card(
                                                    elevation: 0,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2),
                                                      child: ListTile(
                                                        leading:
                                                            CachedNetworkImage(
                                                          imageUrl: orders
                                                              .orderList[index]
                                                              .items![itemIndex]
                                                              .menuItem!
                                                              .image!,
                                                          imageBuilder: (ctx,
                                                                  imageProvider) =>
                                                              Container(
                                                            height:
                                                                mainWidth / 5,
                                                            width:
                                                                mainWidth / 5,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              image: DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .fill),
                                                            ),
                                                          ),
                                                          placeholder: (context,
                                                                  url) =>
                                                              Shimmer
                                                                  .fromColors(
                                                            child: Container(
                                                              height:
                                                                  mainWidth / 5,
                                                              width:
                                                                  mainWidth / 5,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                image:
                                                                    DecorationImage(
                                                                  image: AssetImage(
                                                                      "assets/images/farmhouse.jpg"),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                            baseColor: Colors
                                                                .grey[300]!,
                                                            highlightColor:
                                                                Colors
                                                                    .grey[400]!,
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        ),
                                                        title: Text(
                                                          "${orders.orderList[index].items![itemIndex].menuItem!.name}",
                                                          style: TextStyle(
                                                            fontSize:
                                                                FontSize.small2,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        subtitle: Text(
                                                          "${Get.find<GlobalController>().currencyCode!}${orders.orderList[index].items![itemIndex].unitPrice} x ${orders.orderList[index].items![itemIndex].quantity} = ${Get.find<GlobalController>().currencyCode!}${orders.orderList[index].items![itemIndex].itemTotal}",
                                                          style: TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            fontSize:
                                                                FontSize.small,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ),
                                                        trailing: Column(
                                                          children: [
                                                            Text(
                                                              "${Get.find<GlobalController>().currencyCode!}${orders.orderList[index].items![itemIndex].itemTotal}",
                                                              style: TextStyle(
                                                                fontSize:
                                                                    FontSize
                                                                        .medium,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 5,
                                  left: 10,
                                  child: Container(
                                    height: 20,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: orders.orderList[index].status ==
                                              20
                                          ? Colors.green
                                          : orders.orderList[index].status == 14
                                              ? Colors.lightBlue
                                              : orders.orderList[index]
                                                          .status ==
                                                      15
                                                  ? Colors.deepOrangeAccent
                                                  : orders.orderList[index]
                                                              .status ==
                                                          5
                                                      ? Colors.yellow[900]
                                                      : ThemeColors
                                                          .baseThemeColor,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${orders.orderList[index].statusName.toString()}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 10,
                                  child: Container(
                                    height: 20,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color:
                                          orders.orderList[index].orderType == 1
                                              ? Colors.green
                                              : Colors.red,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${orders.orderList[index].orderTypeName.toString()}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )),
    );
  }
}
