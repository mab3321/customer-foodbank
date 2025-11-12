import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import '/utils/font_size.dart';
import '/utils/theme_colors.dart';
import '../../Controllers/address_controller.dart';
import '../../Controllers/global-controller.dart';
import 'address_add.dart';
import 'address_update.dart';

class AddressList extends StatefulWidget {
  const AddressList({Key? key}) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<AddressList> {
  var mainHeight, mainWidth;
  AddressController addressController = Get.put(AddressController());
  Future<Null> _onRefresh() {
    setState(() {
      addressController.onInit();
    });
    Completer<Null> completer = new Completer<Null>();
    Timer(new Duration(seconds: 0), () {
      completer.complete();
    });
    return completer.future;
  }

  dynamic addressLabel = '';
  String? addressCurrent = '';
  String? addressName = '';
  double? addressLat;
  double? addressLong;
  final Set<Marker> _markers = {};
  Completer<GoogleMapController> controller1 = Completer();
  late LatLng _lastMapPosition;

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
    addressController.onInit();
    addressLabel = addressController.addressLabelName;
    addressName = addressController.addressName;
    addressCurrent = addressController.addressCurrent;
    addressLat = double.parse(addressController.addressCurrentLat.toString());
    addressLong = double.parse(addressController.addressCurrentLong.toString());
    _lastMapPosition = LatLng(addressLat!, addressLong!);
    _markers.add(
      Marker(
        markerId: MarkerId(151.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: "YOU_ARE_HERE".tr,
          snippet: "THIS_IS_A_CURRENT_LOCATION_SNIPPET".tr,
          onTap: () {},
        ),
        onTap: () {},
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MY_ADDRESS".tr,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: FontSize.xLarge,
            color: Colors.white,
          ),
        ),
        backgroundColor: ThemeColors.baseThemeColor,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: GetBuilder<AddressController>(
        init: AddressController(),
        builder:
            (addressList) => RefreshIndicator(
              onRefresh: _onRefresh,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
                ),
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              top: height * 0.02,
                              left: width * 0.04,
                              right: width * 0.04,
                            ),
                            height: height * 0.21,
                            width: width * 0.99,
                            decoration: BoxDecoration(
                              color: Color(0Xfffdf1f5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: height * 0.02,
                                      left: width * 0.02,
                                      right: width * 0.02,
                                    ),
                                    height: height * 0.12,
                                    width: width * 0.99,
                                    child: GoogleMap(
                                      markers: _markers,
                                      zoomControlsEnabled: false,
                                      zoomGesturesEnabled: false,
                                      rotateGesturesEnabled: false,
                                      scrollGesturesEnabled: false,
                                      mapType: _currentMapType,
                                      initialCameraPosition: CameraPosition(
                                        target: _lastMapPosition,
                                        zoom: 16.4746,
                                      ),
                                      onMapCreated: _onMapCreated,
                                      onCameraMove: _onCameraMove,
                                      myLocationEnabled: false,
                                      compassEnabled: true,
                                      myLocationButtonEnabled: false,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Radio(
                                            value: 'current',
                                            activeColor: Colors.pink,
                                            focusColor: Colors.white,
                                            groupValue: addressLabel,
                                            onChanged: (value) {
                                              setState(() {
                                                addressLabel = value!;
                                              });
                                              addressController.addAddress(
                                                addressLabel,
                                                addressCurrent,
                                                addressLat.toString(),
                                                addressLong.toString(),
                                              );

                                              Get.back(result: "refresh");
                                            },
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            addressLabel = 'current';
                                          });
                                          addressController.addAddress(
                                            addressLabel,
                                            addressCurrent,
                                            addressLat.toString(),
                                            addressLong.toString(),
                                          );
                                          Get.back(result: "refresh");
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                'CURRENT_LOCATION'.tr,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0Xff3f3639),
                                                  fontSize: width * 0.04,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.6,
                                              child: Text(
                                                addressCurrent.toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color(
                                                    0Xffaaa4a6,
                                                  ),
                                                  fontSize: width * 0.032,
                                                ),
                                                overflow: TextOverflow.fade,
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          addressList.address.isEmpty
                              ? Container()
                              : Container(
                                child: ListView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: addressList.address.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                        top: height * 0.01,
                                        left: width * 0.04,
                                        bottom: height * 0.01,
                                      ),
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.black12,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Radio(
                                                value:
                                                    addressList
                                                        .address[index]
                                                        .labelName
                                                        .toString(),
                                                activeColor: Colors.pink,
                                                focusColor: Colors.white,
                                                groupValue: addressLabel,
                                                onChanged: (value) {
                                                  setState(() {
                                                    addressLabel = value!;
                                                  });
                                                  addressController.addAddress(
                                                    addressLabel,
                                                    addressList
                                                        .address[index]
                                                        .address,
                                                    addressList
                                                        .address[index]
                                                        .lat,
                                                    addressList
                                                        .address[index]
                                                        .long,
                                                  );

                                                  Get.back(result: "refresh");
                                                },
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: width * 0.62,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  addressLabel =
                                                      addressList
                                                          .address[index]
                                                          .labelName;
                                                });

                                                addressController.addAddress(
                                                  addressLabel,
                                                  addressList
                                                      .address[index]
                                                      .address,
                                                  addressList
                                                      .address[index]
                                                      .lat,
                                                  addressList
                                                      .address[index]
                                                      .long,
                                                );

                                                Get.back(result: "refresh");
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      addressList
                                                          .address[index]
                                                          .labelName
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color(
                                                          0Xff3f3639,
                                                        ),
                                                        fontSize: width * 0.04,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Container(
                                                    width: width * 0.82,
                                                    child: Text(
                                                      addressList
                                                          .address[index]
                                                          .address
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color(
                                                          0Xffaaa4a6,
                                                        ),
                                                        fontSize: width * 0.032,
                                                      ),
                                                      overflow:
                                                          TextOverflow.fade,
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Get.to(
                                                    AddressUpdatePage(
                                                      addressList
                                                          .address[index]
                                                          .address
                                                          .toString(),
                                                      addressList
                                                          .address[index]
                                                          .lat
                                                          .toString(),
                                                      addressList
                                                          .address[index]
                                                          .long
                                                          .toString(),
                                                      addressList
                                                          .address[index],
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  child: Icon(
                                                    Icons.edit,
                                                    color:
                                                        ThemeColors
                                                            .baseThemeColor,
                                                    size: 25,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 15),
                                              InkWell(
                                                onTap: () {
                                                  addressController
                                                      .addressDelete(
                                                        addressList
                                                            .address[index]
                                                            .id,
                                                      );
                                                  _onRefresh();
                                                },
                                                child: Container(
                                                  child: Icon(
                                                    Icons.delete,
                                                    color:
                                                        ThemeColors
                                                            .baseThemeColor,
                                                    size: 25,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                          SizedBox(height: 80),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 10.0,
                      bottom: 0.0,
                      child: Container(
                        width: width,
                        height: 60.0,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Container(
                          margin: EdgeInsets.only(left: width * 0.20),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => PlacePicker(
                                        apiKey:
                                            Get.find<GlobalController>()
                                                .googleMapApiKey
                                                .toString(), // Put YOUR OWN KEY here.
                                        onPlacePicked: (result) {
                                          Navigator.of(context).pop();
                                        },
                                        selectedPlaceWidgetBuilder: (
                                          _,
                                          selectedPlace,
                                          state,
                                          isSearchBarFocused,
                                        ) {
                                          return isSearchBarFocused
                                              ? Container()
                                              // Use FloatingCard or just create your own Widget.
                                              : FloatingCard(
                                                bottomPosition:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.height *
                                                    0.05,
                                                leftPosition:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.025,
                                                rightPosition:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.025,
                                                width:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.9,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                elevation: 4.0,
                                                color:
                                                    Theme.of(context).cardColor,
                                                child:
                                                    state ==
                                                            SearchingState
                                                                .Searching
                                                        ? _buildLoadingIndicator()
                                                        : _buildSelectionDetails(
                                                          context,
                                                          selectedPlace!,
                                                        ),
                                              );
                                        },
                                        searchingText: '',
                                        initialPosition: _lastMapPosition,
                                        usePinPointingSearch: true,
                                        useCurrentLocation: false,
                                        enableMapTypeButton: false,
                                      ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Container(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: Color(0Xffb8175b),
                                    ),
                                    onPressed: null,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "ADD_NEW_ADDRESS".tr,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0Xffb8175b),
                                      fontSize: width * 0.04,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}

Widget _buildLoadingIndicator() {
  return Container(
    height: 48,
    child: const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(),
      ),
    ),
  );
}

Widget _buildSelectionDetails(BuildContext context, PickResult result) {
  return Container(
    margin: EdgeInsets.all(10),
    child: Column(
      children: <Widget>[
        Text(
          result.formattedAddress!,
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          child: Text(
            "SELECT_HERE".tr,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          onPressed: () {
            Get.to(AddressAddPage(address: result));
          },
        ),
      ],
    ),
  );
}
