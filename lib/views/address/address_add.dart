import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import '../../Controllers/address_controller.dart';
import '../../utils/theme_colors.dart';

class AddressAddPage extends StatefulWidget {
  final PickResult address;
  AddressAddPage({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  _AddressAddPageState createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  SnappingSheetController snappingSheetController = SnappingSheetController();

  late int selectLabel = 0;
  final Set<Marker> _markers = {};
  Completer<GoogleMapController> controller1 = Completer();
  late LatLng _lastMapPosition;
  final _formKey = GlobalKey<FormState>();
  final addressController = Get.put(AddressController());
  late final TextEditingController streetController = TextEditingController();
  late final TextEditingController labelController = TextEditingController();

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller1.complete(controller);
    });
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  MapType _currentMapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    _lastMapPosition = LatLng(widget.address.geometry!.location.lat,
        widget.address.geometry!.location.lng);
    _markers.add(Marker(
        markerId: MarkerId(151.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
            title: "YOU_ARE_HERE".tr,
            snippet: "THIS_IS_A_CURRENT_LOCATION_SNIPPET".tr,
            onTap: () {}),
        onTap: () {},
        icon: BitmapDescriptor.defaultMarker));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 18),
            height: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColors.baseThemeColor, // background
                foregroundColor: Colors.white, // foreground
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // <-- Radius
                ),
              ),
              onPressed: () async {
                if (selectLabel == 15 && labelController.text == '') {
                  Get.rawSnackbar(
                      backgroundColor: Colors.orange,
                      snackPosition: SnackPosition.TOP,
                      message: 'PLEASE_ADD_YOUR_LABEL_NAME'.tr);
                } else {
                  addressController.postAddress(
                      widget.address.geometry!.location.lat,
                      widget.address.geometry!.location.lng,
                      selectLabel,
                      selectLabel == 5
                          ? 'Home'
                          : selectLabel == 10
                              ? 'Work'
                              : labelController.text,
                      widget.address.formattedAddress.toString(),
                      streetController.text);
                  streetController.clear();
                  labelController.clear();
                }
              },
              child: Text(
                'SAVE_ADDRESS'.tr,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        color: Colors.white,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SnappingSheet(
          // Connect it to the SnappingSheet
          controller: snappingSheetController,
          snappingPositions: const [
            SnappingPosition.pixels(
              positionPixels: 300,
              snappingCurve: Curves.elasticOut,
              snappingDuration: Duration(milliseconds: 1750),
            ),
            SnappingPosition.factor(
              positionFactor: 0.77,
              snappingCurve: Curves.easeOutExpo,
              snappingDuration: Duration(seconds: 1),
              grabbingContentOffset: GrabbingContentOffset.top,
            ),
            SnappingPosition.factor(
              positionFactor: 0.75,
              snappingCurve: Curves.bounceOut,
              snappingDuration: Duration(seconds: 1),
              grabbingContentOffset: GrabbingContentOffset.bottom,
            ),
          ],
          grabbingHeight: 5,
          grabbing: GestureDetector(
            onTap: () {
              snappingSheetController.snapToPosition(
                SnappingPosition.factor(positionFactor: 0.90),
              );
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
            ),
          ),
          sheetBelow: SnappingSheetContent(
            sizeBehavior: SheetSizeStatic(size: 300),
            draggable: true,
            child: Container(
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 16),
                  child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ADD_A_NEW_ADDRESS'.tr,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.add_location,
                                            color: ThemeColors.baseThemeColor,
                                            size: 25),
                                        SizedBox(width: 10),
                                        Flexible(
                                            child: Text(
                                          widget.address.formattedAddress
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: ThemeColors.darkFont,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                        SizedBox(width: 20),
                                        InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                            child: Icon(Icons.edit,
                                                color:
                                                    ThemeColors.baseThemeColor,
                                                size: 25),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "APARTMENT".tr,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            height: 70,
                                            child: TextFormField(
                                              controller: streetController,
                                              textInputAction:
                                                  TextInputAction.done,
                                              keyboardType: TextInputType.text,
                                              cursorColor:
                                                  ThemeColors.primaryColor,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                  top: 0,
                                                  left: 15,
                                                ),
                                                fillColor:
                                                    const Color(0xffF2CDD4),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: ThemeColors
                                                        .primaryColor,
                                                  ),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: ThemeColors
                                                        .primaryColor,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: ThemeColors
                                                        .primaryColor,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xffF2CDD4),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'ADD_A_LABEL'.tr,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    decoration: BoxDecoration(
                                                        color: selectLabel == 5
                                                            ? ThemeColors
                                                                .baseThemeColor
                                                            : Colors.white,
                                                        shape: BoxShape.circle,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black12,
                                                            offset:
                                                                const Offset(
                                                              5.0,
                                                              2.0,
                                                            ),
                                                            blurRadius: 10.0,
                                                            spreadRadius: 5.0,
                                                          ),
                                                        ]),
                                                    child: Center(
                                                      child: IconButton(
                                                          color: selectLabel ==
                                                                  5
                                                              ? Colors.white
                                                              : ThemeColors
                                                                  .baseThemeColor,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          iconSize: 30,
                                                          icon: const Icon(
                                                              Icons.home),
                                                          onPressed: () {
                                                            setState(() {
                                                              selectLabel = 5;
                                                            });
                                                            // do something
                                                          }),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "HOME".tr,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    decoration: BoxDecoration(
                                                        color: selectLabel == 10
                                                            ? ThemeColors
                                                                .baseThemeColor
                                                            : Colors.white,
                                                        shape: BoxShape.circle,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black12,
                                                            offset:
                                                                const Offset(
                                                              5.0,
                                                              2.0,
                                                            ),
                                                            blurRadius: 10.0,
                                                            spreadRadius: 5.0,
                                                          ),
                                                        ]),
                                                    child: Center(
                                                      child: IconButton(
                                                          color: selectLabel ==
                                                                  10
                                                              ? Colors.white
                                                              : ThemeColors
                                                                  .baseThemeColor,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          iconSize: 30,
                                                          icon: const Icon(
                                                              Icons.shop),
                                                          onPressed: () {
                                                            setState(() {
                                                              selectLabel = 10;
                                                            });
                                                            // do something
                                                          }),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "WORK".tr,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    decoration: BoxDecoration(
                                                        color: selectLabel == 15
                                                            ? ThemeColors
                                                                .baseThemeColor
                                                            : Colors.white,
                                                        shape: BoxShape.circle,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black12,
                                                            offset:
                                                                const Offset(
                                                              5.0,
                                                              2.0,
                                                            ),
                                                            blurRadius: 10.0,
                                                            spreadRadius: 5.0,
                                                          ),
                                                        ]),
                                                    child: Center(
                                                      child: IconButton(
                                                          color: selectLabel ==
                                                                  15
                                                              ? Colors.white
                                                              : ThemeColors
                                                                  .baseThemeColor,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          iconSize: 30,
                                                          icon: const Icon(
                                                              Icons.add),
                                                          onPressed: () {
                                                            setState(() {
                                                              selectLabel = 15;
                                                            });
                                                            // do something
                                                          }),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "OTHER".tr,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          selectLabel == 15
                                              ? Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "LABEL_NAME".tr,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: 70,
                                                      child: TextFormField(
                                                        controller:
                                                            labelController,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        cursorColor: ThemeColors
                                                            .primaryColor,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 0,
                                                            left: 15,
                                                          ),
                                                          fillColor:
                                                              const Color(
                                                                  0xffF2CDD4),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            borderSide:
                                                                const BorderSide(
                                                              width: 1,
                                                              color: ThemeColors
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            borderSide:
                                                                const BorderSide(
                                                              width: 1,
                                                              color: ThemeColors
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            borderSide:
                                                                const BorderSide(
                                                              width: 1,
                                                              color: ThemeColors
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            borderSide:
                                                                const BorderSide(
                                                              width: 1,
                                                              color: Color(
                                                                  0xffF2CDD4),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ],
                                ))
                          ]))),
            ),
          ),

          child: GoogleMap(
            markers: _markers,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: false,
            rotateGesturesEnabled: false,
            scrollGesturesEnabled: false,
            mapType: _currentMapType,
            initialCameraPosition: CameraPosition(
              target: _lastMapPosition,
              zoom: 15.4746,
            ),
            onMapCreated: _onMapCreated,
            onCameraMove: _onCameraMove,
            myLocationEnabled: false,
            compassEnabled: true,
            myLocationButtonEnabled: false,
          ),
        ), // This trailing com
      ),
    );
  }
}
