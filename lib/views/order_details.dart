import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '/Controllers/global-controller.dart';
import '/Controllers/order_details_controller.dart';
import '/utils/font_size.dart';
import '/utils/image.dart';
import '/utils/size_config.dart';
import '/utils/theme_colors.dart';
import '/widgets/shimmer/order_details_shimmer.dart';

class OrderDetails extends StatefulWidget {
  final orderId;
  OrderDetails({required this.orderId});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int statusValue = 0;
  int statusActive = 1;

  final settingsController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    final orderDetailsController =
        Get.put(OrderDetailsController(widget.orderId));

    Future<Null> _onRefresh() {
      setState(() {
        orderDetailsController.onInit();
      });
      Completer<Null> completer = new Completer<Null>();
      Timer(new Duration(seconds: 3), () {
        completer.complete();
      });
      return completer.future;
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _onRefresh();
    });
    showAlertDialog(BuildContext context, id) {
      // set up the buttons
      Widget cancelButton = TextButton(
        child: Text("YES".tr),
        onPressed: () {
          orderDetailsController.cancelOrder(id);
          Navigator.of(context).pop();
        },
      );

      Widget noButton = TextButton(
        child: Text("NO".tr),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text('ORDER_CANCEL?'.tr),
        content: Text('ARE_YOU_SURE_YOU_WANT_TO_CANCEL_THE_ORDER'.tr),
        actions: [
          noButton,
          cancelButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return GetBuilder<OrderDetailsController>(
      init: OrderDetailsController(widget.orderId),
      builder: (orderDetails) => orderDetails.orderDetailsDataLoader
          ? OrderDetailsShimmer()
          : Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => Get.back()),
                title: Text(
                  "ORDER_DETAILS".tr,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: FontSize.xLarge,
                      color: Colors.white),
                ),
                backgroundColor: ThemeColors.baseThemeColor,
                centerTitle: true,
                elevation: 0.0,
              ),
              bottomNavigationBar: Container(
                  decoration: BoxDecoration(
                      color: ThemeColors.baseThemeColor.withOpacity(.1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  height: MediaQuery.of(context).size.height / 4.0,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  'SUB_TOTAL'.tr,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${Get.find<GlobalController>().currency!}${orderDetails.subTotal}",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  child: Text(
                                'DELIVERY_FEE'.tr,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                              Container(
                                  child: Text(
                                "${Get.find<GlobalController>().currency!}${orderDetails.deliveryCharge}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              )),
                            ],
                          ),
                        ),
                        Divider(color: Colors.grey),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  child: Text(
                                'TOTAL'.tr,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                              Container(
                                  child: Text(
                                "${Get.find<GlobalController>().currency!}${orderDetails.total}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              )),
                            ],
                          ),
                        ),
                        if (orderDetails.statusCode == 5)
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: ThemeColors.baseThemeColor,
                                    side: BorderSide(
                                      width: 0.0,
                                      color: ThemeColors.baseThemeColor,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20), // <-- Radius
                                    ),
                                  ),
                                  onPressed: () {
                                    showAlertDialog(context, widget.orderId);
                                  },
                                  child: Text(
                                    'CANCEL'.tr,
                                    style: TextStyle(
                                      color: ThemeColors.baseThemeColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (orderDetails.statusCode == 10)
                          Text('ORDER_CANCELLED'.tr,
                              style: TextStyle(color: Colors.red)),
                        Container(),
                      ],
                    ),
                  )),
              body: RefreshIndicator(
                onRefresh: _onRefresh,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  statusActive = 1;
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 150,
                                decoration: statusActive == 1
                                    ? BoxDecoration(
                                        color: ThemeColors.baseThemeColor,
                                        borderRadius: BorderRadius.circular(40))
                                    : BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.fromBorderSide(
                                            BorderSide(
                                                color: ThemeColors
                                                    .baseThemeColor))),
                                child: Center(
                                    child: Text('DETAILS'.tr,
                                        style: TextStyle(
                                            color: statusActive == 1
                                                ? Colors.white
                                                : ThemeColors.baseThemeColor))),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  statusActive = 2;
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 150,
                                decoration: statusActive == 2
                                    ? BoxDecoration(
                                        color: ThemeColors.baseThemeColor,
                                        borderRadius: BorderRadius.circular(40))
                                    : BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.fromBorderSide(
                                            BorderSide(
                                                color: ThemeColors
                                                    .baseThemeColor))),
                                child: Center(
                                    child: Text('TRACKING_ORDER'.tr,
                                        style: TextStyle(
                                            color: statusActive == 2
                                                ? Colors.white
                                                : ThemeColors.baseThemeColor))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      statusActive == 1
                          ? ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 1.0, horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "ORDER_NO".tr +
                                                    " #${orderDetails.orderCode}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                "${Get.find<GlobalController>().currency!}${orderDetails.total}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "ORDER".tr +
                                                    " ${orderDetails.statusName}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${orderDetails.createdTime} ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "ITEMS".tr +
                                                    " ${orderDetails.itemList.length} ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //   Stepper
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 20, bottom: 10, left: 15),
                                        child: Row(
                                          children: [
                                            Icon(
                                                Icons.shopping_basket_outlined),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "SHOP_DETAILS".tr,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: ThemeColors
                                                      .scaffoldBgColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth,
                                        child: Card(
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                left: 5,
                                                right: 5),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 0,
                                                  child: CachedNetworkImage(
                                                    imageUrl: orderDetails
                                                        .restaurantImage
                                                        .toString(),
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                            width: SizeConfig
                                                                    .screenWidth! /
                                                                4,
                                                            height: SizeConfig
                                                                    .screenWidth! /
                                                                4,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10.0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10.0)),
                                                            ),
                                                            child: Image(
                                                                image:
                                                                    imageProvider)),
                                                    placeholder:
                                                        (context, url) =>
                                                            Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[300]!,
                                                      highlightColor:
                                                          Colors.grey[400]!,
                                                      child: Container(
                                                        width: SizeConfig
                                                                .screenWidth! /
                                                            4,
                                                        height: SizeConfig
                                                                .screenWidth! /
                                                            4,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10.0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10.0)),
                                                        ),
                                                        child: Image(
                                                          image: AssetImage(
                                                              Images
                                                                  .shimmerImage),
                                                        ),
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        orderDetails
                                                            .restaurantName
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color: ThemeColors
                                                                .scaffoldBgColor),
                                                      ),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      Text(
                                                        orderDetails
                                                            .restaurantAddress
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 14,
                                                            color: ThemeColors
                                                                .greyTextColor),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 0,
                                                    child: InkWell(
                                                      onTap: () {
                                                        //changehere
                                                        void _launchMapsUrl(
                                                            lat, long) async {
                                                          final url =
                                                              'https://www.google.com/maps/search/?api=1&query=$lat,$long';
                                                          // ignore: deprecated_member_use
                                                          if (await canLaunch(
                                                              url)) {
                                                            // ignore: deprecated_member_use
                                                            await launch(url);
                                                          } else {
                                                            throw 'Could not launch $url';
                                                          }
                                                        }

                                                        _launchMapsUrl(
                                                            orderDetails.resLat,
                                                            orderDetails
                                                                .resLong);
                                                      },
                                                      child: SizedBox(
                                                        height: 100,
                                                        width: 45,
                                                        child: Icon(
                                                            FontAwesomeIcons
                                                                .mapLocation,
                                                            color: ThemeColors
                                                                .baseThemeColor),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 10),
                                    child: Center(
                                      child: Text(
                                        "ORDERED_ITEMS".tr,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: ThemeColors.baseThemeColor),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: ListView.builder(
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: orderDetails.itemList.length,
                                      itemBuilder: (context, index) {
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
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                child: ListTile(
                                                  leading: CachedNetworkImage(
                                                    imageUrl: orderDetails
                                                        .itemList[index]
                                                        .menuItem!
                                                        .image!,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      height: SizeConfig
                                                              .screenWidth! /
                                                          5,
                                                      width: SizeConfig
                                                              .screenWidth! /
                                                          5,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            Shimmer.fromColors(
                                                      child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            5,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            5,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  "assets/images/farmhouse.jpg"),
                                                              fit: BoxFit.fill),
                                                        ),
                                                      ),
                                                      baseColor:
                                                          Colors.grey[300]!,
                                                      highlightColor:
                                                          Colors.grey[400]!,
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                  title: Text(
                                                    "${orderDetails.itemList[index].menuItem!.name}",
                                                    style: TextStyle(
                                                      fontSize:
                                                          FontSize.xMedium,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${Get.find<GlobalController>().currency!}${orderDetails.itemList[index].unitPrice} x ${orderDetails.itemList[index].quantity} = ${Get.find<GlobalController>().currency!}${orderDetails.itemList[index].itemTotal}",
                                                        style: TextStyle(
                                                          overflow:
                                                              TextOverflow.fade,
                                                          fontSize:
                                                              FontSize.medium,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                      orderDetails
                                                                  .itemList[
                                                                      index]
                                                                  .menuItem!
                                                                  .options!
                                                                  .length ==
                                                              0
                                                          ? Container()
                                                          : Container(
                                                              height: 20,
                                                              width: SizeConfig
                                                                      .screenWidth! /
                                                                  2,
                                                              child: ListView
                                                                  .builder(
                                                                itemCount:
                                                                    orderDetails
                                                                        .itemList[
                                                                            index]
                                                                        .options!
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                            itemIndex) =>
                                                                        Text(
                                                                  itemIndex ==
                                                                          orderDetails.itemList[index].options!.length -
                                                                              1
                                                                      ? '${orderDetails.itemList[index].options![itemIndex].name}'
                                                                      : '${orderDetails.itemList[index].options![itemIndex].name}, ',
                                                                  style:
                                                                      TextStyle(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .fade,
                                                                    fontSize:
                                                                        FontSize
                                                                            .small,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                  ),
                                                                ),
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                physics:
                                                                    ScrollPhysics(),
                                                                shrinkWrap:
                                                                    true,
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                  trailing: Column(
                                                    children: [
                                                      Text(
                                                        "${Get.find<GlobalController>().currency!}${orderDetails.itemList[index].itemTotal}",
                                                        style: TextStyle(
                                                          fontSize:
                                                              FontSize.medium,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                    ),
                                  ),
                                  settingsController.supportNum == null
                                      ? Container()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 20,
                                                  bottom: 10,
                                                  left: 15),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                      FontAwesomeIcons
                                                          .phoneVolume,
                                                      color: ThemeColors
                                                          .baseThemeColor),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "SUPPORT_NUMBER".tr,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                        color: ThemeColors
                                                            .scaffoldBgColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: SizeConfig.screenWidth,
                                              child: Card(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      left: 5,
                                                      right: 5),
                                                  child: Row(
                                                    children: [
                                                      //shop image container
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .headset,
                                                        color: ThemeColors
                                                            .baseThemeColor,
                                                        size: 40,
                                                      ),
                                                      SizedBox(
                                                        width: 30,
                                                      ),

                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'CALL_YOUR_SUPPORT'
                                                                  .tr,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16,
                                                                  color: ThemeColors
                                                                      .scaffoldBgColor),
                                                            ),
                                                            SizedBox(
                                                              height: 2,
                                                            ),
                                                            Text(
                                                              '${settingsController.supportNum.toString()}',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  fontSize: 14,
                                                                  color: ThemeColors
                                                                      .greyTextColor),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          _makePhoneCall(
                                                              settingsController
                                                                  .supportNum
                                                                  .toString());
                                                        },
                                                        icon: Icon(
                                                          Icons.phone_enabled,
                                                          color: ThemeColors
                                                              .baseThemeColor,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ])
                          : Container(),
                      statusActive == 2
                          ? ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              children: [
                                orderDetails.deliveryBoyId == null
                                    ? Container()
                                    : Container(
                                        padding: EdgeInsets.only(
                                            top: 20, bottom: 10, left: 15),
                                        child: Row(
                                          children: [
                                            Icon(Icons.person),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "DELIVERY_BOY_INFORMATION".tr,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: ThemeColors
                                                      .scaffoldBgColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                orderDetails.deliveryBoyId == null
                                    ? Container()
                                    : Container(
                                        width: SizeConfig.screenWidth,
                                        child: Card(
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                left: 5,
                                                right: 5),
                                            child: Row(
                                              children: [
                                                //shop image container
                                                CachedNetworkImage(
                                                  imageUrl: orderDetails
                                                      .deliveryBoyImage!,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                          width: SizeConfig
                                                                  .screenWidth! /
                                                              4,
                                                          height: SizeConfig
                                                                  .screenWidth! /
                                                              4,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10.0)),
                                                          ),
                                                          child: Image(
                                                              image:
                                                                  imageProvider)),
                                                  placeholder: (context, url) =>
                                                      Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey[300]!,
                                                    highlightColor:
                                                        Colors.grey[400]!,
                                                    child: Container(
                                                      width: SizeConfig
                                                              .screenWidth! /
                                                          4,
                                                      height: SizeConfig
                                                              .screenWidth! /
                                                          4,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10.0)),
                                                      ),
                                                      child: Image(
                                                        image: AssetImage(Images
                                                            .shimmerImage),
                                                      ),
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),

                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        orderDetails
                                                            .deliveryBoyName
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color: ThemeColors
                                                                .scaffoldBgColor),
                                                      ),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      Text(
                                                        orderDetails
                                                            .deliveryBoyEmail
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 14,
                                                            color: ThemeColors
                                                                .greyTextColor),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            orderDetails
                                                                .deliveryBoyPhone
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize: 14,
                                                                color: ThemeColors
                                                                    .greyTextColor),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          IconButton(
                                                            icon: Icon(Icons
                                                                .phone_enabled),
                                                            onPressed: () =>
                                                                _makePhoneCall(
                                                                    orderDetails
                                                                        .deliveryBoyPhone
                                                                        .toString()),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                Container(
                                  child: Theme(
                                    data: ThemeData(
                                      colorScheme:
                                          ColorScheme.fromSwatch().copyWith(
                                        primary: ThemeColors.baseThemeColor,
                                      ),
                                    ),
                                    child: Stepper(
                                      physics: ClampingScrollPhysics(),
                                      controlsBuilder: (BuildContext context,
                                          ControlsDetails controls) {
                                        return SizedBox(height: 0.0);
                                      },
                                      steps: getTrackingSteps(
                                          context,
                                          orderDetails.statusName,
                                          orderDetails.statusCode.toString()),
                                      currentStep: statusValue,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  List<Step> getTrackingSteps(BuildContext context, statusName, status) {
    print(status);
    List<Step> _orderStatusSteps = [];
    if (status == '10') {
      _orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Text(
          'ORDER_CANCEL'.tr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: SizedBox(
            width: double.infinity,
            child: Text(
              '',
            )),
        isActive: int.tryParse(status)! >= int.tryParse('10')!,
      ));
    } else {
      _orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Text(
          'ORDER_PENDING'.tr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: SizedBox(
          width: double.infinity,
          child: Text(
            '',
            style: TextStyle(
                color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        isActive: int.tryParse(status)! >= int.tryParse('5')!,
      ));
    }
    if (status == '12') {
      _orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Text(
          'ORDER_REJECT'.tr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: SizedBox(
            width: double.infinity,
            child: Text(
              '',
            )),
        isActive: int.tryParse(status)! >= int.tryParse('12')!,
      ));
    } else {
      _orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Text(
          'ORDER_ACCEPT'.tr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: SizedBox(
            width: double.infinity,
            child: Text(
              '',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )),
        isActive: int.tryParse(status)! >= int.tryParse('14')!,
      ));
    }
    _orderStatusSteps.add(Step(
      state: StepState.complete,
      title: Text(
        'ORDER_PROCESS'.tr,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: SizedBox(
          width: double.infinity,
          child: Text(
            '',
            style: TextStyle(
                color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
          )),
      isActive: int.tryParse(status)! >= int.tryParse('15')!,
    ));
    _orderStatusSteps.add(Step(
      state: StepState.complete,
      title: Text(
        'ON_THE_WAY'.tr,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: SizedBox(
          width: double.infinity,
          child: Text(
            '',
            style: TextStyle(
                color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
          )),
      isActive: int.tryParse(status)! >= int.tryParse('17')!,
    ));
    _orderStatusSteps.add(Step(
      state: StepState.complete,
      title: Text(
        'ORDER_COMPLETED'.tr,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: SizedBox(
          width: double.infinity,
          child: Text(
            '',
            style: TextStyle(
                color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
          )),
      isActive: int.tryParse(status)! >= int.tryParse('20')!,
    ));
    return _orderStatusSteps;
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  // switchStepsType() {
  //   setState(() => stepperType == StepperType.vertical
  //       ? stepperType = StepperType.horizontal
  //       : stepperType = StepperType.vertical);
  // }
  //
  // tapped(int step) {
  //   setState(() => _currentStep = step);
  // }
  //
  // continued() {
  //   _currentStep < 4 ? setState(() => _currentStep += 1) : null;
  // }
  //
  // cancel() {
  //   _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  // }
}
