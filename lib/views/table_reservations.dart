import 'package:flutter/material.dart';
import '/Controllers/table_ReservationsController.dart';
import '/utils/theme_colors.dart';
import '/widgets/shimmer/table_reservation_shimmer.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'no_reservation_found.dart';

class TableReservations extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TableReservationsState();
  }
}

class _TableReservationsState extends State<TableReservations> {
  var mainHeight, mainWidth;
  String cancelDialogue = "ARE_YOU_SURE_YOU_WANT_TO_CANCEL_THE_RESERVATION?".tr;
  String dialogueCancel = "RESERVATION_CANCEL?".tr;

  final tableReservationController = Get.put(TableReservationsController());

  @override
  void initState() {
    tableReservationController.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return GetBuilder<TableReservationsController>(
      init: TableReservationsController(),
      builder: (tbcntlr) => tbcntlr.tableReservationLoader
          ? TableReservationShimmer()
          : Container(
              color: Colors.white10,
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  centerTitle: true,
                  title: Text(
                    'TABLE_RESERVATIONS'.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  backgroundColor: ThemeColors.baseThemeColor,
                ),
                body: RefreshIndicator(
                  onRefresh: _refresh,
                  child: tbcntlr.reservationsList.isEmpty
                      ? NoReservationFound()
                      : ListView.builder(
                          itemCount: tbcntlr.reservationsList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Stack(children: [
                                Card(
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor:
                                          Colors.black, // here for close state
                                      colorScheme: ColorScheme.light(
                                        primary: Colors.black,
                                      ), // here for open state in replacement of deprecated accentColor
                                      dividerColor: Colors
                                          .transparent, // if you want to remove the border
                                    ),
                                    child: ExpansionTile(
                                      key: Key(index.toString()), //attention
                                      initiallyExpanded: index == 0,
                                      title: Container(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        width: mainWidth,
                                        height: mainHeight / 8,
                                        child: Row(
                                          children: [
                                            //image_container
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              width: mainWidth / 6,
                                              height: mainHeight / 12,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    bottomLeft:
                                                        Radius.circular(10.0)),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    tbcntlr
                                                                .reservationsList[
                                                                    index]
                                                                .guest! >=
                                                            4
                                                        ? "assets/images/table1.png"
                                                        : "assets/images/table2.png",
                                                  ),
                                                  fit: BoxFit.fill,
                                                  //alignment: Alignment.topCenter,
                                                ),
                                              ),
                                            ),

                                            // Description container
                                            Expanded(
                                              child: Container(
                                                //  color: Colors.green,

                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          child: Text(
                                                            '${tbcntlr.reservationsList[index].table}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          " ${tbcntlr.reservationsList[index].createdAt} ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //expanded container
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 20.0,
                                              left: 20,
                                              top: 10,
                                              right: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "${tbcntlr.reservationsList[index].restaurantName} ",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.person_pin,
                                                    color: ThemeColors
                                                        .baseThemeColor,
                                                    size: 27,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "${tbcntlr.reservationsList[index].restaurantEmail} ",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: (() {}),
                                                    child: Icon(
                                                      Icons.email_outlined,
                                                      color: ThemeColors
                                                          .baseThemeColor,
                                                      size: 27,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "${tbcntlr.reservationsList[index].restaurantPhone} ",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: (() {
                                                      _makePhoneCall(tbcntlr
                                                          .reservationsList[
                                                              index]
                                                          .restaurantPhone
                                                          .toString());
                                                    }),
                                                    child: Icon(
                                                      Icons.phone_enabled,
                                                      color: ThemeColors
                                                          .baseThemeColor,
                                                      size: 27,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "NO_OF_GUEST".tr,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "${tbcntlr.reservationsList[index].guest} ",
                                                        style: TextStyle(
                                                            //  color: Colors.grey,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .supervised_user_circle,
                                                    color: ThemeColors
                                                        .baseThemeColor,
                                                    size: 27,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${tbcntlr.reservationsList[index].restaurantOpeningTime} -  ${tbcntlr.reservationsList[index].restaurantClosingTime}",
                                                        style: TextStyle(
                                                            // color: Colors.grey,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )
                                                    ],
                                                  ),
                                                  Icon(
                                                    Icons.access_time_sharp,
                                                    color: ThemeColors
                                                        .baseThemeColor,
                                                    size: 27,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            "${tbcntlr.reservationsList[index].restaurantAddress} ",
                                                            style: TextStyle(
                                                                //  color: Colors.grey,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.place,
                                                    color: ThemeColors
                                                        .baseThemeColor,
                                                    size: 27,
                                                  )
                                                ],
                                              ),
                                              tbcntlr.reservationsList[index]
                                                          .status ==
                                                      1
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20,
                                                              bottom: 0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                            width:
                                                                mainWidth / 2.5,
                                                            height: 30,
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                //  elevation: 0.0,
                                                                backgroundColor:
                                                                    Colors
                                                                        .red, // background
                                                                foregroundColor:
                                                                    Colors
                                                                        .white, // foreground
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10), // <-- Radius
                                                                ),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                setState(() {
                                                                  showAlertDialog(
                                                                      context,
                                                                      dialogueCancel,
                                                                      cancelDialogue,
                                                                      '3',
                                                                      tbcntlr
                                                                          .reservationsList[
                                                                              index]
                                                                          .id
                                                                          .toString());
                                                                });
                                                              },
                                                              child: Text(
                                                                'CANCEL'.tr,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 1,
                                  left: MediaQuery.of(context).size.width / 2.8,
                                  child: Center(
                                    child: Container(
                                      height: 25,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: tbcntlr.reservationsList[index]
                                                    .status !=
                                                2
                                            ? ThemeColors.baseThemeColor
                                            : Colors.green,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Center(
                                        child: Text(
                                          tbcntlr.reservationsList[index]
                                              .statusName
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            );
                          },
                        ),
                ),
              ),
            ),
    );
  }

  Future<Null> _refresh() async {
    print('refreshing stocks...');
    tableReservationController.onInit();
    await Future.delayed(new Duration(seconds: 3));
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  showAlertDialog(
      BuildContext context, dialogueAccpet, String alertMessage, status, id) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("CANCEL".tr),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("CONTINUE".tr),
      onPressed: () {
        tableReservationController.changeReservationStatus(status, id);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(dialogueAccpet),
      content: Text(alertMessage),
      actions: [
        cancelButton,
        continueButton,
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
}
